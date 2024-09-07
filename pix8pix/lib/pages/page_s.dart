import 'package:flutter/material.dart';
import 'package:pix8pix/pages/home.dart';

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A"),
      ),
      body: Center(
          child: ElevatedButton.icon(
              onPressed: () {}, icon: Icon(Icons.home), label: Text('A'))),
    );
  }
}

class B extends StatefulWidget {
  const B({super.key});

  @override
  State<B> createState() => _BState();
}

class _BState extends State<B> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B"),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.home),
            label: const Text('b')),
      ),
    );
  }
}

class C extends StatefulWidget {
  const C({super.key});

  @override
  State<C> createState() => _CState();
}

class _CState extends State<C> {
  @override
  Widget build(BuildContext context) {
    var params = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("C"),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/x');
            },
            icon: const Icon(Icons.home),
            label: Text('C $params')),
      ),
    );
  }
}
