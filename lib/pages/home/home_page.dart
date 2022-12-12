import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Text("Text"),
        ),
      ),
      drawer: Drawer(
        child: _getDrawerItems(),
      ),
    );
  }

  _getDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text("Name"),
      accountEmail: Text("Email"),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
  }

  _getDrawerItems() {
    return ListView(
      children: [
        _getDrawerHeader(),
        ListTile(
          title: const Text("Logout"),
          leading: const Icon(Icons.logout),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
