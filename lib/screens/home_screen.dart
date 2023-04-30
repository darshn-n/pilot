// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:chauffeur/services/firebase_services.dart';
import 'package:chauffeur/widgets/product_display_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chauffeur/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home-screen";

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kscreenBackground,
        elevation: 0.0,
        title: Text(
          'My Posts',
          style: GoogleFonts.raleway(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Press back again to Exit'),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              8,
              12,
              8,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: service.products.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    'Something went wrong',
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 140.0,
                      right: 140,
                    ),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      color: Colors.grey.shade100,
                    ),
                  );
                }

                if (snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 56,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'My Recent Posts',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 450,
                            childAspectRatio: 3.5 / 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.size,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.docs[index];
                            // Display Card:
                            return ProductDisplayCard(
                              data: data,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      "You haven't Posted Recently",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Greet:

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12 && hour > 5) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }

  return 'Good Evening';
}
