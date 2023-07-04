
import 'package:flutter/material.dart';
//import '../model/to_do.dart';
import 'package:diary/sql_helper.dart';

class TaskListTile extends StatelessWidget {
  final bool isChecked;
  final String tasktitle;
  final String taskbody;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  final VoidCallback onUpdate;

  const TaskListTile({
    required this.isChecked,
    required this.tasktitle,
    required this.taskbody,
    required this.onDelete,
    required this.onToggle,
    required this.onUpdate,
  });

    @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: onToggle,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            ),
          contentPadding: EdgeInsets.symmetric(horizontal:20,vertical:5,),
          tileColor: Colors.white,
          leading: isChecked
              ? Icon(Icons.check_box)
              : Icon(Icons.check_box_outline_blank),

          title: Text(tasktitle,
            style:  TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold ,
              color:Colors.blueGrey,
              decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
          ),
          subtitle: Text(taskbody,
            style:  TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold ,
              color:Colors.black54,
            ),
          ),
          //onTap: onToggle,
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.blueGrey,
                  iconSize: 21,
                  icon: Icon(Icons.edit),
                  onPressed: onUpdate,

                ),
            IconButton(
              color: Colors.redAccent,
              iconSize: 21,
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
            ]
            )

          ),
    );


  }
}
class Taskmethods extends StatefulWidget {
  @override
  State<Taskmethods> createState() => _TaskmethodsState();
}

class _TaskmethodsState extends State<Taskmethods> {
 // const Taskmethods({Key? key}) : super(key: key);
  List<Task> taskList = [];

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    final tasks = await DatabaseHelper.getTasks();
    setState(() {
      taskList = tasks;
    });
  }

  void _toggleItem(int index) {
    setState(() {
     taskList[index].isChecked = !taskList[index].isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
