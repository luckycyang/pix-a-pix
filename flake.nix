{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    devenv.url = "github:cachix/devenv";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };


  outputs = { self, nixpkgs, devenv, rust-overlay, ... } @ inputs:
    let
      overlays = [ (import rust-overlay) ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
        config.android_sdk.accept_license = true;
      };
      rustpkg = pkgs.rust-bin.stable.latest.default.override
        {
          extensions = [ "rust-src" "rustfmt" "clippy" "rust-analyzer" "rustc" ]; # rust-src for rust-analyzer
          targets = [ "x86_64-unknown-linux-gnu" "wasm32-unknown-unknown" ];
        };
    in
    {
      packages.${system}.devenv-up = self.devShells.${system}.default.config.procfileScript;
      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ({ pkgs, config, ... }: {
            # This is your devenv configuration
            android = {
              enable = true;
              abis = [
                "android-x64"
                "arm64-v8a"
                "x86_64"
              ];
              flutter.enable = true;
              android-studio.enable = false;
            };
            languages.c.enable = true;
            languages.cplusplus.enable = true;
            packages = [
              pkgs.ninja
              rustpkg
            ];
            env = { };
          })
        ];
      };
    };
}
