import 'package:chauffeur/screens/success_screen.dart';
import 'package:chauffeur/providers/category_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Future<dynamic> confirmDialog(
    BuildContext context, CategoryProvider catProvider) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Are you sure you want to Post this Product?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: Text(
                    catProvider.dataToCloud['vehicleType'],
                    maxLines: 3,
                  ),
                  subtitle: Text(
                    catProvider.dataToCloud['to'],
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Colors.transparent,
                      ),
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SuccessScreen.id);
                      },
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
