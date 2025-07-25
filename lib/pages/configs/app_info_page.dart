import 'package:flutter/material.dart';
import 'package:notef_fschmatz/util/app_details.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  void _launchGithub() {
    launchUrl(
      Uri.parse(AppDetails.repositoryLink),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("App Info"),
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.lightGreen,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(AppDetails.appName + " " + AppDetails.appVersion,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: themeColorApp)),
          ),
          const SizedBox(height: 15),
          ListTile(
            title: Text("Dev", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              "Application created using Flutter and the Dart language, used for testing and learning.",
            ),
          ),
          ListTile(
            title: Text("Source Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: themeColorApp)),
          ),
          ListTile(
            onTap: () {
              _launchGithub();
            },
            leading: const Icon(Icons.open_in_new_outlined),
            title: const Text("View on GitHub",
                style: TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.blue, color: Colors.blue)),
          ),
          ListTile(
            title: Text("Quote", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              "The key to efficient development is to make interesting new mistakes.",
            ),
          ),
        ]));
  }
}
