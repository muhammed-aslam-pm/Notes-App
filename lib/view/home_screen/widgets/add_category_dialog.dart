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
      title: Text("Add category"),
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
          contentPadding: EdgeInsets.all(20),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.primaryColor)),
          onPressed: () {
            categoryController.clear();
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              catController.addUserCategory(categoryController.text);
              categoryController.clear();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Category added success full")));
              fetchdata();
            },
            child: Text("Add"))
      ],
    );
  }
}
