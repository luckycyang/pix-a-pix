import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn = false;
  String _username = '';
  String? _lastCloseTime;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      setState(() {
        _isLoggedIn = true;
        _username = prefs.getString('username') ?? '';
        _lastCloseTime = prefs.getString('lastCloseTime');
      });
    }
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'user' && password == 'password') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);

      setState(() {
        _isLoggedIn = true;
        _username = username;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');
    await prefs.remove('lastCloseTime');

    setState(() {
      _isLoggedIn = false;
      _username = '';
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  Future<void> _saveCloseTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String now = DateTime.now().toString();
    await prefs.setString('lastCloseTime', now);
  }

  @override
  void dispose() {
    _saveCloseTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello, $_username!'),
                if (_lastCloseTime != null)
                  Text('Last close time: $_lastCloseTime'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _logout,
                  child: Text('Logout'),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
              ],
            ),
          );
  }
}
