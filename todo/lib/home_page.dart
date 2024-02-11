import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:try1/data/database.dart';
import 'package:try1/util/todo_tile.dart';
import 'package:try1/util/tododialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refernce the box
  final _myBox= Hive.box("mytodobox");

  //text controller
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // check if ot'is first time opening box

    if(_myBox.get("TODOLIST")== null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }


    super.initState();
  }



   //checkboxChanged
   void CheckboxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.UpdateData();

   }

   // save new task
   void SaveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.UpdateData();
   }

   //create new task
   void createNewTask(){
    showDialog(context: context, builder: (context) {
      return tododialog(
        controller: _controller,
        onSave: SaveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });

   }

   //
   void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.UpdateData();

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("ToDo"),
        
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        ),



      body: ListView.builder(
       itemCount: db.todoList.length,
      itemBuilder: (context, index) {
        return TodoTile(
          taskName: db.todoList[index][0],
         taskCompleted: db.todoList[index][1],
          onChanged: (value) => CheckboxChanged(value, index),
          deleteFunction: (context) => deleteTask (index),
          );
      },
      ),
    );
  }
}

class ToDoDAtabase {
}