import 'package:flutter/material.dart';
import 'package:to_do_project_1/utils/color_constants.dart';

import 'widgets/note_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              itemBuilder: (context, index) => NoteWidgets(),
              separatorBuilder: (context, index) => Divider(
                    height: 20,
                  ),
              itemCount: 10),
        ),
      ),
    );
  }

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
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "Description",
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
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: null,
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
                        4,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                    color: ColorConstants.secondaryColor3,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
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
                        onPressed: () {},
                        child: Text("Add")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
