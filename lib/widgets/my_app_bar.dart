// ignore_for_file: must_be_immutable

import 'package:chauffeur/constants/colors.dart';
import 'package:chauffeur/widgets/account_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: AppBar(
        toolbarHeight: 120,
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: kscreenBackground,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Expanded(
              child: Text(
                title,
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Colors.black,
                ),
                maxLines: 3,
              ),
            ),
          ),
        ),
        actions: [
          Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    backgroundColor: kscreenBackground,
                    context: context,
                    builder: (BuildContext context) {
                      return const AccountDropDown();
                    },
                  );
                },
                child: ClipOval(
                  child: Image.network(
                    'http://via.placeholder.com/640x360',
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    color: Colors.grey.shade800,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              15.0,
                            ),
                          ),
                        ),
                        backgroundColor: kscreenBackground,
                        context: context,
                        builder: (BuildContext context) {
                          return const AccountDropDown();
                        },
                      );
                    },
                    child: Text(
                      'Account',
                      style: GoogleFonts.raleway(
                        color: Colors.grey.shade800,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
