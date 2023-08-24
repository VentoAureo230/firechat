import 'package:firechat/components/list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function() onProfileTap;
  final void Function() onSignOut;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // header
          Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 64,
              )),
              // home list tile
              ListTileDrawer(
                icon: Icons.home,
                text: 'Home',
                onTap: () => Navigator.pop(context),
              ),
              // profile list tile
              ListTileDrawer(
                icon: Icons.person,
                text: 'Profile',
                onTap: onProfileTap,
              ),
            ],
          ),
          //logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTileDrawer(
              icon: Icons.logout,
              text: 'Logout',
              onTap: onSignOut,
            ),
          )
        ],
      ),
    );
  }
}
