import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_project_1/model/category_model.dart';

class CategoryController {
  void initializeApp() async {
    // List of default categories
    List<String> defaultCategories = ['Work', 'Personal', 'Ideas'];

    // Check if categories already exist
    final Box<Category> categoryBox = Hive.box<Category>('categories');
    bool categoriesExist = categoryBox.isNotEmpty;

    // If default categories don't exist, add them
    if (!categoriesExist) {
      for (String categoryName in defaultCategories) {
        categoryBox.add(Category(categoryName));
      }
    }
  }

// Function to add a user-defined category
  void addUserCategory(String categoryName) {
    final Box<Category> categoryBox = Hive.box<Category>('categories');
    categoryBox.add(Category(categoryName));
  }

  // Function to get all categories
  List<Category> getAllCategories() {
    final Box<Category> categoryBox = Hive.box<Category>('categories');
    return categoryBox.values.toList();
  }
}
