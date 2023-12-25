import 'package:flutter/material.dart';
import 'package:todoappp/constants/color.dart';
import 'package:todoappp/constants/db_handler.dart';
import 'package:todoappp/model/todo_model.dart';
import 'package:todoappp/screens/add_tasks.dart';

import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  String keyword = '';



  @override
  Widget build(BuildContext context) {
    final data = DBHandler().read();
    return GestureDetector(
      onTap: (){
        searchFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(),
        body:Stack(
          children: [
            // Yellow Conatiner
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.26,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    tdYellow.withAlpha(101)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                boxShadow: [
                  BoxShadow(
                    color: tdYellow,
                    blurRadius: 5,
                    spreadRadius: 2
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft:Radius.circular(20)
                )
              ),
            ),
            Column(
              children: [
                //search Field Container
                searchBar(),
                //your Tasks Text
                Container(
                  margin: EdgeInsets.only(top: 40,bottom: 10),
                  child: Text(
                    'Your Tasks',
                    style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color:tdYellow,
                          blurRadius: 5,
                          offset: Offset(1, 1)
                        )
                      ]
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: keyword.isEmpty  ?
                    DBHandler().read()
                    :
                    DBHandler().searchItems(keyword)
                    ,
                      builder: (context,AsyncSnapshot<List<TodoModel>> snapshot) {
                        if(!snapshot.hasData){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }else if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }else{
                            return Center();
                          }
                        }else{
                          if(snapshot.data!.isNotEmpty){
                            var tileData = snapshot.data!;
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 25),
                              itemCount: tileData.length,
                              itemBuilder: (context, index) {
                                return TodoItem(
                                  data: tileData[index],
                                  deleteTask: deleteTask,
                                );
                              },
                            );
                          }else{
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 100,
                                    color: textColor,
                                  ),
                                  Text(
                                    'No tasks yet',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: textColor
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        }
                          if(snapshot.hasData){
                            var tileData = snapshot.data!;

                          }else{
                            return Center(
                              child: Text('No Data')
                            );

                          }
                      },
                  ),
                )
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed:() async{
              searchFocusNode.unfocus();
              searchController.clear();
              String data = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(),));
              if(data == 'data'){
                setState(() {

                });
              }
          },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            elevation: 5,
            child: Text(
              '+',
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(top: 30,left: 15,right: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    offset: Offset(1, 1),
                    color: textColor,
                    spreadRadius: 0
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: searchController,
                focusNode: searchFocusNode,
                onChanged: (value){
                  setState(() {
                    keyword = value.toString();
                  });

                },
                decoration: InputDecoration(
                  contentPadding:EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: tdYellow,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: tdYellow
                  )
                ),
              ),
            );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 30,
            color: tdYellow,
          ),
          Container(
            width: 40,
            height: 40,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }

  deleteTask(int id){
    DBHandler().delete(id);
    setState(() {

    });
  }
}
