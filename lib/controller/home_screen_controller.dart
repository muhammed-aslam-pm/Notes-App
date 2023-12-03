import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_project_1/model/category_model.dart';

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
