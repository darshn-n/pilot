// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chauffeur/constants/colors.dart';
import 'package:chauffeur/providers/category_provider.dart';
import 'package:chauffeur/services/firebase_services.dart';
import 'package:chauffeur/widgets/confirm_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SellerForm extends StatefulWidget {
  const SellerForm({Key? key}) : super(key: key);
  static const String id = "seller-form";

  @override
  State<SellerForm> createState() => _SellerFormState();
}

class _SellerFormState extends State<SellerForm> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection("uploads");

  final FirebaseService _service = FirebaseService();
  String postID = const Uuid().v1();

  final _numberOfSeatsController = TextEditingController();
  final _costController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _boardingTimeController = TextEditingController();
  validate(CategoryProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.dataToCloud.addAll(
        {
          'vehicleType': provider.selectedCategory,
          'cost': _costController.text,
          'vehicleNumber': _vehicleNumberController.text,
          'from': _fromController.text,
          'numberOfSeats': _numberOfSeatsController.text,
          'to': _toController.text,
          'boardingTime': _boardingTimeController.text,
          'postID': postID
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Required Fields are Missing.",
          ),
        ),
      );
    }
  }

  Future<void> saveProductToDb(CategoryProvider provider, context) {
    return _service.products
        .doc(postID)
        .set(
          provider.dataToCloud,
        )
        .then(
      (value) {
        provider.clearData();
      },
    ).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to Update',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);

    showConfirmDialog() {
      return confirmDialog(context, catProvider);
    }

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        title: const Text(
          "Add your Journey",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    catProvider.selectedCategory.toString(),
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: _numberOfSeatsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Number of Seats*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the required Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _vehicleNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Vehicle Number*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the required Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // TextFormField(
                  //   controller: _boardingTimeController,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: "Boarding Time*",
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Please enter the required Field";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: _boardingTimeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Boarding Time*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the required Field";
                      }
                      return null;
                    },
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(FocusNode());

                      TimeOfDay? picked = await showTimePicker(
                          context: context, initialTime: time);
                      if (picked != null && picked != time) {
                        _boardingTimeController.text =
                            picked.format(context).toString();
                        setState(() {
                          time = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "From*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "From?";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "To*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "To?";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _costController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cost*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cost?";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "Post",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  validate(catProvider);
                  showConfirmDialog();
                  saveProductToDb(catProvider, context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
