import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/tasks.dart';
import 'widgets/menu.dart';

import 'package:diary/sql_helper.dart';



//import 'package:flutter_todo_app/constants/colors.dart';
void main() => runApp(DiaryApp()
);

class DiaryApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: simpleDiary(),
    );
  }
}

class simpleDiary extends StatefulWidget {
  const simpleDiary({Key? key}) : super(key: key);

  @override
  State<simpleDiary> createState() => _simpleDiaryState();
}

class _simpleDiaryState extends State<simpleDiary> {


  List<Task> taskList = [];
  List<Task> _originalTaskList = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  final TextEditingController _addtitleController = TextEditingController();

  final TextEditingController _addsubtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    final tasks = await DatabaseHelper.getTasks();
    setState(() {
      taskList = tasks;
      _originalTaskList = List.from(taskList);
    });
  }

  Future<void> _addTask() async {
    final tasktitle = _addtitleController.text;
    final taskbody = _addsubtitleController.text;
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      tasktitle:  tasktitle,
      taskbody:  taskbody,
    );
    await DatabaseHelper.insertTask(task);
    setState(() {
      _addtitleController.clear();
      _addsubtitleController.clear();
    });
    _refreshTasks();
  }
  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _addtitleController,
                decoration: InputDecoration(
                  labelText: 'Task Title ',
                ),
              ),
              TextField(
                controller: _addsubtitleController,
                decoration: InputDecoration(
                  labelText: 'Task body',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateTask(int id, String tasktitle, String taskbody) async {
    await DatabaseHelper.updateTask(id,tasktitle,  taskbody);
    _refreshTasks();
  }
  void _showUpdateTaskDialog(BuildContext context, int index) {

    final task= taskList[index];
    _titleController.text =task.tasktitle;
    _subtitleController.text = task.taskbody;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                ),
              ),
              TextField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  labelText: 'Task body',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateTask(task.id, _titleController.text, _subtitleController.text);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _toggletask(int index) {
    setState(() {
      taskList[index].isChecked = !taskList[index].isChecked;
    });
  }
  void _onSearchTextChanged(String text) {
    setState(() {
      taskList = _originalTaskList.where((task) => task.tasktitle.toLowerCase().contains(text.toLowerCase())
          ||
         task.taskbody.toLowerCase().contains(text.toLowerCase())).toList();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],

      appBar:(_buildAppBar()),

      drawer: MyDrawer(),
      body:  Stack(
          children: [

           // Container(
              //color: Colors.pink.withOpacity(0.2),
            //),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20,),
                            child: Center(
                              child: Text('Tasks to do', style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                              ),)
                        ),
                        for( final task in taskList.reversed)
                          TaskListTile(
                            isChecked: task.isChecked,
                            tasktitle: task.tasktitle,
                            taskbody: task.taskbody,
                            onDelete: () async {
                              await DatabaseHelper.deleteTask(task.id);
                              _refreshTasks();
                            },
                            onToggle: () {
                              _toggletask(taskList.indexOf(task));
                            },
                            onUpdate: () {
                              _showUpdateTaskDialog(context, taskList.indexOf(task));
                            },

                          )
                      ],
                    ),
                  )

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(
                      fontSize: 40,),),
                    onPressed: () {
                      _showAddTaskDialog(context);
                                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),

                  ),
                )

            )
          ],
        ),

    );

  }


  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: _onSearchTextChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search,
            color: Colors.black54,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20, minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.pink[100],
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 250),
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),

              child: Image.asset('assets/diary1.jpg'),
            ),
          ),
        ],
      ),
    );
  }
  }





