import 'package:flutter/material.dart';
import 'package:to_do_project_1/controller/home_screen_controller.dart';

import '../../../utils/color_constants.dart';

class RemoveCategoryDialog extends StatelessWidget {
  const RemoveCategoryDialog(
      {super.key,
      required this.categoryName,
      required this.categoryIndex,
      required this.fetchData});
  final String categoryName;
  final int categoryIndex;
  final void Function() fetchData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Dlete $categoryName ?"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              CategoryController().removeUserCategory(
                  catIndex: categoryIndex, fetchData: fetchData);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$categoryName deleted success full")));
              fetchData();
            },
            child: const Text("Delete"))
      ],
    );
  }
}
