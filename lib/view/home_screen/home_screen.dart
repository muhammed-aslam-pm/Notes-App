import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_project_1/model/notes_display_model.dart';
import 'package:to_do_project_1/model/notes_model.dart';
import 'package:to_do_project_1/utils/color_constants.dart';
import '../../controller/home_screen_controller.dart';
import 'widgets/note_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var noteBox = Hive.box<NotesModel>('noteBox');
//category controller object
  CategoryController catController = CategoryController();

  //notes controller object
  NotesController notesController = NotesController();

// category list from hive category box
  List categories = [];
  // Index of selected category
  int categoryIndex = 0;
//category controller
  TextEditingController categoryController = TextEditingController();

  // adding/editing form controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // adding/editing form key
  final _formKey = GlobalKey<FormState>();

  //Notes list

  List<NotesModel> myNotes = [];
  List<NotesModel> categorizedNotes = [];
  Map<int, List<NotesModel>> groupedNotes = {};

  List<NotesDisplayModel> notesDisplay = [];

  //keys list
  List myKeysList = [];

  @override
  void initState() {
    catController.initializeApp();
    categories = catController.getAllCategories();
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    myKeysList = await noteBox.keys.toList();
    myNotes = noteBox.values.toList();

    for (var n in myKeysList) {
      notesDisplay.add(NotesDisplayModel(
        title: noteBox.get(n)!.title,
        description: noteBox.get(n)!.description,
        date: noteBox.get(n)!.date,
        category: noteBox.get(n)!.category,
        key: n,
      ));
    }

    for (var note in myNotes) {
      if (!groupedNotes.containsKey(note.category)) {
        groupedNotes[note.category] = [];
      }
      if (!groupedNotes[note.category]!.contains(note)) {
        groupedNotes[note.category]!.add(note);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: Colors.white),
        ),
        elevation: 0,
        onPressed: () => bottomSheet(context),
        child: Icon(Icons.add),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: ListView.separated(
              itemBuilder: (context, index) {
                int category = groupedNotes.keys
                    .elementAt(groupedNotes.length - index - 1);
                List<NotesModel> notesInCategory = groupedNotes[category]!;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[groupedNotes.keys
                            .elementAt(groupedNotes.length - index - 1)],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.primaryColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(notesInCategory.length,
                                (inIndex) {
                          return NoteWidgets(
                            title: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .title,
                            description: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .description,
                            date: notesInCategory[
                                    notesInCategory.length - inIndex - 1]
                                .date,
                            onDelete: () {},
                          );
                        })),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                    height: 20,
                  ),
              itemCount: groupedNotes.length),
        ),
      ),
    );
  }

// Bottom sheet extracted
  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderSide: BorderSide(width: 0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, InsetState) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: ColorConstants.primaryColor,
                            )),
                        isDense: false, // Added this
                        contentPadding: EdgeInsets.all(20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Description",

                          labelStyle: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: ColorConstants.primaryColor,
                              )),
                          isDense: false, // Added this
                          contentPadding: EdgeInsets.all(20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            categories.length + 1,
                            (index) => index == categories.length
                                ? InkWell(
                                    onTap: () => AddCategory(context),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        " + Add Category",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: InkWell(
                                      onTap: () {
                                        categoryIndex = index;
                                        InsetState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                            color: categoryIndex == index
                                                ? Colors.black
                                                : ColorConstants
                                                    .secondaryColor3,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          categories[index].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorConstants.primaryColor)),
                            onPressed: () {
                              notesController.addNotes(
                                  formkey: _formKey,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  date: DateFormat('dd,MM,yyyy')
                                      .format(DateTime.now())
                                      .toString(),
                                  category: categoryIndex,
                                  context: context,
                                  descriptionController: descriptionController,
                                  titleController: titleController,
                                  fetchdata: fetchData);

                              setState(() {});
                            },
                            child: Text("Add")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> AddCategory(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add category"),
          content: TextField(
            controller: categoryController,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Category",
              labelStyle: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () {
                  catController.addUserCategory(categoryController.text);
                  Navigator.pop(context);
                  categories = catController.getAllCategories();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Category added success full")));
                  setState(() {});
                },
                child: Text("Add"))
          ],
        ),
      );
}
