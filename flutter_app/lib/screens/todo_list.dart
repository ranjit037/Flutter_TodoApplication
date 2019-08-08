import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_edit_todo.dart';
import 'package:flutter_app/Database.dart';
import 'package:flutter_app/TodoModel.dart';

class TodoListVC extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return TodoListVCState();
  }
}

class TodoListVCState extends State<TodoListVC> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('My Todo List'),
      ),

      body: FutureBuilder<List<TodoList>>(
        future: DBProvider.db.getAllTodoList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TodoList>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                TodoList item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteClient(item.id);
                  },
                  child: ListTile(
                    title: Text(item.description),
                    leading: Text(item.title),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBProvider.db.checkOrUncheck(item);
                        setState(() {});
                      },
                      value: item.isChecked,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTodo(pageTitle: "Add Task"),
            ),
          );
        },

        tooltip: 'Add Todo',

        child: Icon(Icons.add),

      ),
    );
  }
}







