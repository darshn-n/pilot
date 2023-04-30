import 'package:chauffeur/widgets/logout_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AccountDropDown extends StatefulWidget {
  const AccountDropDown({super.key});

  @override
  State<AccountDropDown> createState() => _AccountDropDownState();
}

class _AccountDropDownState extends State<AccountDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 25,
                right: 25,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ClipOval(
              child: Image.network(
                FirebaseAuth.instance.currentUser!.photoURL!,
                width: 70,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${FirebaseAuth.instance.currentUser!.displayName}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(
                  0xff050609,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${FirebaseAuth.instance.currentUser!.email}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            const LogoutAlert(),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}


