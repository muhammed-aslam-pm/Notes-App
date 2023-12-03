import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_project_1/model/notes_model.dart';

class CategoryController {
  final CatBox = Hive.box('categories');
  void initializeApp() async {
    // List of default categories
    List<String> defaultCategories = ['Work', 'Personal', 'Ideas'];

    // Check if categories already exist

    bool categoriesExist = CatBox.isNotEmpty;

    // If default categories don't exist, add them
    if (!categoriesExist) {
      for (String categoryName in defaultCategories) {
        CatBox.add(categoryName);
      }
    }
  }

// Function to add a user-defined category
  void addUserCategory(String categoryName) {
    CatBox.add(categoryName);
  }

  // Function to get all categories
  List getAllCategories() {
    return CatBox.values.toList();
  }
}

class NotesController {
  final noteBox = Hive.box<NotesModel>('noteBox');
  void addNotes(
      {required GlobalKey<FormState> formkey,
      required String title,
      required String description,
      required date,
      required int category,
      required TextEditingController titleController,
      required TextEditingController descriptionController,
      required BuildContext context,
      required void fetchdata()}) {
    if (formkey.currentState!.validate()) {
      noteBox.add(NotesModel(
          title: title,
          description: description,
          date: date,
          category: category));
      titleController.clear();
      descriptionController.clear();
      Navigator.pop(context);
      fetchdata();
    }
  }

  List<NotesModel> getSortedNotesByCategory({required List<NotesModel> list}) {
    list.sort((a, b) => a.category.compareTo(b.category));
    return list;
  }
}
