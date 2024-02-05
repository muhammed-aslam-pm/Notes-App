import 'package:flutter/material.dart';
import 'package:to_do_project_1/controller/home_screen_controller.dart';
import 'package:to_do_project_1/utils/color_constants.dart';
import 'package:to_do_project_1/view/note_page/note_page.dart';

class NoteWidgets extends StatelessWidget {
  const NoteWidgets(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.onDelete,
      required this.onUpdate,
      required this.category});

  final String title;
  final String description;
  final String date;
  final String category;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(
                  title: title,
                  description: description,
                  date: date,
                  category: category),
            )),
        child: Container(
          height: 210,
          width: MediaQuery.sizeOf(context).width - 80,
          decoration: BoxDecoration(
              color: ColorConstants.primaryCardColor,
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 216,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: onUpdate,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: onDelete,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        String note =
                            "$title \n\n $description \n \n                          $date";
                        NotesController().shareNote(note: note);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
