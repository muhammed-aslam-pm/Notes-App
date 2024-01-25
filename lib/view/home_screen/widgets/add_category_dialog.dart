import 'package:flutter/material.dart';
import 'package:to_do_project_1/controller/home_screen_controller.dart';

import '../../../utils/color_constants.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog(
      {super.key,
      required this.categoryController,
      required this.catController,
      required this.fetchdata});
  final TextEditingController categoryController;
  final CategoryController catController;
  final void Function() fetchdata;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add category"),
      content: TextField(
        controller: categoryController,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: "Category",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorConstants.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: TextStyle(
            color: ColorConstants.primaryColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: ColorConstants.primaryColor,
              )),
          isDense: false, // Added this
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(ColorConstants.primaryColor),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
          ),
          onPressed: () {
            categoryController.clear();
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.primaryColor),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
            ),
            onPressed: () {
              catController.addUserCategory(categoryController.text);
              categoryController.clear();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Category added success full")));
              fetchdata();
            },
            child: const Text("Add"))
      ],
    );
  }
}
