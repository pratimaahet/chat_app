import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helper/helper_function.dart';
import '../pages/auth/login_page.dart';
import '../pages/profile_page.dart';
import '../services/auth_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });

    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 50),
      children: <Widget>[
        Icon(Icons.account_circle, size: 150, color: Colors.grey[700]),
        const SizedBox(
          height: 15,
        ),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
          onTap: () {
            nextScreenReplace(context, HomePage());
          },
          selectedColor: Theme.of(context).primaryColor,
          selected: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.group),
          title: const Text(
            "Groups",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            nextScreenReplace(context, ProfilePage());
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.person),
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to Logout?"),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )),
                      IconButton(
                        onPressed: () async {
                          await authService.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                });

            // authService.signOut().whenComplete(() {
            //   nextScreenReplace(context, LoginPage());
            // });
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.exit_to_app),
          title: const Text(
            "Logout",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ],
    ));
  }
}
