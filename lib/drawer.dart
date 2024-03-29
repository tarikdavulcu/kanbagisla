import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanbagisla/homepage.dart';
import 'package:kanbagisla/profile.dart';
import 'package:kanbagisla/rankinglist.dart';
import 'package:kanbagisla/settings.dart';
import 'package:localstorage/localstorage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, User? token});

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('key');

    User? user = storage.getItem('token');

    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.50,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color(0xff764abc)),
                accountName: user!.displayName == null
                    ? Text(
                        user.uid.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        user.displayName.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                accountEmail: Text(
                  user.email.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: user.photoURL == null
                    ? const FlutterLogo()
                    : Image.network(user.photoURL.toString()),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('İlanlar'),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HomePage(title: "İlanlar", usr: user)));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text('Ayarlar'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Settings()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: const Text('Profil'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.emoji_events,
                ),
                title: const Text('Sıralama Listesi'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RankingList()));
                },
              ),
              const AboutListTile(
                // <-- SEE HERE
                icon: Icon(
                  Icons.info,
                ),
                // ignore: sort_child_properties_last
                child: Text('Hakkında'),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'Kan Bağışı',
                applicationVersion: '1.0.1',
                applicationLegalese: '© 2023 Company',
                aboutBoxChildren: [
                  ///Content goes here...
                ],
              ),
            ],
          ),
        ));
  }
}
