import 'package:flutter/material.dart';
import 'package:todoappp/constants/color.dart';
import 'package:todoappp/constants/db_handler.dart';
import 'package:todoappp/model/todo_model.dart';
class TodoItem extends StatefulWidget {
  final data;
  final deleteTask;
  const TodoItem({
    super.key,
    required this.data,
    required this.deleteTask
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {

  final titleCOntroller = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: textColor,
            blurRadius: 2,
            offset: Offset(1, 1)
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: tdYellow
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        onTap: (){
          if(widget.data.checkbox == 0){
            widget.data.checkbox = 1;
          }else{
            widget.data.checkbox = 0;
          }
          setState(() {});
        },
        title: Text(
          '${widget.data.title}',
          style: TextStyle(
            decoration: widget.data.checkbox == 0 ? TextDecoration.none : TextDecoration.lineThrough,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600
          ),
        ),
        subtitle: Text(
          '${widget.data.description}',
          style: TextStyle(
              decoration: widget.data.checkbox == 0 ? TextDecoration.none : TextDecoration.lineThrough,
            fontStyle: FontStyle.italic,
            color: textColor
          ),
        ) ,
        leading: Icon(
          widget.data.checkbox == 0 ? Icons.check_box_outline_blank
          :
          Icons.check_box
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: IconButton(
                  onPressed:(){
                    showAlertBox();
                  } ,
                  icon: Icon(Icons.edit),
                iconSize: 20,
                color: tdYellow,
              ),
            ),
            SizedBox(width: 10,),
            Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: IconButton(
                  onPressed: () async{
                    int id = await widget.data.id;
                    widget.deleteTask(id);

                  } ,
                  icon: Icon(Icons.delete),
                iconSize: 20,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAlertBox(){
    String title  = widget.data.title;
    String desc = widget.data.description;

    titleCOntroller.text = title;
    descriptionController.text = desc;

   showDialog(
     useSafeArea: true,
       context: context,
       builder: (context) {
         return AlertDialog(
           backgroundColor: tdYellow.withAlpha(200),
           title: Center(
             child: Text(
               'Edit',
               style: TextStyle(
                 color: textColor,
                 fontWeight: FontWeight.bold
               ),
             ),
           ),
           content: Container(
             margin: EdgeInsets.only(top: 20),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 // Title TextField
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 15),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20),
                     boxShadow: [
                       BoxShadow(
                         blurRadius: 1,
                         spreadRadius: 0,
                         offset: Offset(1, 1)
                       )
                     ]
                   ),
                   child: TextFormField(
                     controller: titleCOntroller ,
                     style: TextStyle(color: tdYellow),
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.all(10),
                       hintText: 'Title',
                       hintStyle: TextStyle(color: tdYellow),
                       border: InputBorder.none,
                       prefixIcon: Icon(
                         Icons.title,
                         size: 20,
                         color: tdYellow,
                       ),
                       prefixIconConstraints: BoxConstraints(
                         maxHeight: 30,
                         minWidth: 25
                       )
                     ),
                   ),
                 ),
                 SizedBox(height: 10,),
                 //Descripton TextField
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 15),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(
                             blurRadius: 1,
                             spreadRadius: 0,
                             offset: Offset(1, 1)
                         )
                       ]
                   ),
                   child: TextFormField(
                     controller: descriptionController,
                     maxLines: 2,
                     style: TextStyle(color: tdYellow),
                     decoration: InputDecoration(
                         contentPadding: EdgeInsets.all(10),
                         hintText: 'Description',
                         hintStyle: TextStyle(color: tdYellow, height: 3),
                         border: InputBorder.none,
                         prefixIcon: Icon(
                           Icons.title,
                           size: 20,
                           color: tdYellow,
                         ),
                         prefixIconConstraints: BoxConstraints(
                             maxHeight: 30,
                             minWidth: 25
                         )
                     ),
                   ),
                 ),
               ],
             ),
           ),
           actions: [
             TextButton(
                 onPressed: (){
                   Navigator.pop(context);
                 },
                 child: Text(
                     'Cancel',
                   style: TextStyle(
                     color: Colors.red
                   ),
                 )
             ),
             TextButton(
                 onPressed:() async{
                   Map<String, Object?> dataRow = TodoModel(
                       title: titleCOntroller.text,
                       description: descriptionController.text,
                     id: widget.data.id
                   ).toMap();
                   await DBHandler().update(dataRow);
                   Navigator.pop(context);
                 } ,
                 child: Text(
                   'Save',
                   style: TextStyle(
                     color: Colors.black
                   ),
                 )
             )
           ],
         );
       },
   );
  }
}
