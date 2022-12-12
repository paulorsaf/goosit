import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _getDrawerItems(),
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
