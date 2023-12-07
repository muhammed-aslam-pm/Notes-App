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
  final noteBox = Hive.box('noteBox');

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
      var note;
      List<NotesModel> currentNotes = [];
      if (noteBox.containsKey(category)) {
        currentNotes = noteBox.get(category);
        note = NotesModel(
            title: title,
            description: description,
            date: date,
            category: category);
        currentNotes.add(note);

        noteBox.put(category, currentNotes);
      } else {
        note = NotesModel(
            title: title,
            description: description,
            date: date,
            category: category);
        currentNotes.add(note);

        noteBox.put(category, currentNotes);
      }
      titleController.clear();
      descriptionController.clear();
      Navigator.pop(context);
      fetchdata();
    }
  }

  void deleteNote({
    required var key,
    required NotesModel note,
    required void Function() fetchData,
    required int index,
  }) {
    List<NotesModel> list = noteBox.get(key)!.cast<NotesModel>();
    print("before: $list");
    print("index: $index");
    print("lis length  : ${list.length}");

    if (index < 0 || index >= list.length) {
      print("Invalid index: $index. Index out of range.");
      return; // Exit the function if index is out of range
    }

    print("before2: $list");
    list.remove(note);
    print("after: $list");
    noteBox.put(key, list);
    print("updated: ${noteBox.get(key)}");

    if (list.length == 0) {
      noteBox.delete(key);
    }
  }
}
