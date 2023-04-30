// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chauffeur/providers/product_provider.dart';
import 'package:chauffeur/screens/product_details_screen.dart';
import 'package:chauffeur/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDisplayCard extends StatefulWidget {
  const ProductDisplayCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  State<ProductDisplayCard> createState() => _ProductDisplayCardState();
}

class _ProductDisplayCardState extends State<ProductDisplayCard> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return BlurryContainer(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        onTap: () {
          provider.getProductDetails(widget.data);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ProductDetailsScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Price:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.data['vehicleType'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Boarding Time: ${widget.data['boardingTime']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "From : ${widget.data['from']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "To : ${widget.data['to']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Cost : \u{20B9} ${widget.data['cost']}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
