import 'package:flutter/material.dart';
import 'package:flutter_app/TodoModel.dart';
import 'package:flutter_app/Database.dart';



class AddEditTodo extends StatelessWidget {

  final String pageTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  AddEditTodo({this.pageTitle});

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[

            // First element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (titleController.text.trim() != "") {
                          TodoList newValue1 = TodoList(title: titleController.text,description: descriptionController.text,createdDate: DateTime.now().millisecondsSinceEpoch,isChecked: false);
                          DBProvider.db.newTodoList(newValue1);
                          Navigator.pop(context);
                        }

                      },
                    ),
                  ),

                  Container(width: 5.0,),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}










