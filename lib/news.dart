import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:new_lesionia_project/services/myuser_service.dart';
import 'package:new_lesionia_project/services/news_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  bool checking = false;
  Timer? _timer;
  var _controller = TextEditingController();
  List messages = [].reversed.toList();
  var dataliste = [];
  var userList = [];
  String nom = "";
  @override
  void initState() {
    var data;
    var user;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _loadCounter();
      data = await News_Service.getallnews(context);
      if (data != null) {
        print(data);
        EasyLoading.addStatusCallback((status) {
          print('EasyLoading Status $status');
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          dataliste = data;
        });
        // dataliste.forEach((element) async {
        //   user =
        //       await Myuser_Service.getUserbyID(element['loginuser'], context);
        //   if (userList.isEmpty) {
        //     setState(() {
        //       userList.add(user);
        //     });
        //   } else if (userList.isNotEmpty &&
        //       userList.contains(user['loginuser'])) {
        //   } else {
        //     userList.add(user);
        //   }
        // });

        dataliste.forEach((element) async {
          user =
              await Myuser_Service.getUserbyID(element['loginuser'], context);
          if (id == element['loginuser']) {
            setState(() {
              checking = true;
            });
          } else {
            setState(() {
              checking = false;
            });
          }

          setState(() {
            // if (id == element['loginuser']) {
            //   var msg = Message(
            //       data: element['loginuser'],
            //       id: element['newsidentifier'].toString(),
            //       text: element['news_CONTENT'],
            //       date: DateFormat("yyyy-MM-dd")
            //           .parse(element['publication_DATE']),
            //       isSentByMe: checking);
            //   messages.add(msg);
            // } else {
            var msg = Message(
              //firstname: user['first_NAME_INTERROGATOR'],
//              lastname: user['last_NAME_INTERROGATOR'],
                data: element['loginuser'],
                id: element['newsidentifier'].toString(),
                text: element['news_CONTENT'],
                date:
                    DateFormat("yyyy-MM-dd").parse(element['publication_DATE']),
                isSentByMe: checking);
            messages.add(msg);
            // }
          });
        });
      }
    });
    super.initState();
  }

  var id;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getString('id') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (new Color(0xff088274)),
                Colors.greenAccent,
              ],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            )
          },
        ),
        title: Center(child: Text('Lesionia News')),
        backgroundColor: Color(0xFF077064),
      ),
      body: (messages.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GroupedListView<dynamic, DateTime>(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    elements: messages,
                    groupBy: (message) => DateTime(message.date.year,
                        message.date.month, message.date.day),
                    groupHeaderBuilder: (dynamic message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, dynamic message) => Column(
                      children: [
                        if (message.data != id) ...[
                        //  if (message.firstname != null &&
                             // message.lastname != null)
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                               //   message.firstname +
                                  //    " " +
                                    //  message.lastname +
                                 //     " :"
                                    message,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue[900]),
                                ),
                              ),
                            ),
                        ],
                        Container(
                          padding:
                              EdgeInsets.only(left: 14, right: 14, bottom: 10),
                          child: Align(
                            alignment: message.isSentByMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (message.isSentByMe == true)
                                      ? Colors.blue[300]
                                      : Colors.grey.shade300),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                                onPressed: (message.isSentByMe == true)
                                    ? () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8.5,
                                                  child: ListTile(
                                                    leading: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    title: TextButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                              BuildContext
                                                                  contextt,
                                                            ) {
                                                              return CupertinoAlertDialog(
                                                                title: const Text(
                                                                    'Alert !'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      ListBody(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          "Are you sure that you want to delete this message ?"),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'Yes'),
                                                                    onPressed:
                                                                        () async {
                                                                      await News_Service.deleteMessage(
                                                                          message
                                                                              .id
                                                                              .toString(),
                                                                          context);
                                                                      // if (messages.contains(
                                                                      //     message)) {
                                                                      //   setState(() {
                                                                      //     messages.remove(
                                                                      //         message);
                                                                      //   });
                                                                      // } else {
                                                                      //   print("error");
                                                                      // }
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                            'No'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          contextt);
                                                                    },
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Text(
                                                          "Delete this message",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        )),
                                                  ));
                                            });
                                      }
                                    : () {},
                                child: Column(
                                  children: [
                                    // if (message.data != id) ...[
                                    //   if (message.firstname != null &&
                                    //       message.lastname != null)
                                    //     Text(
                                    //       message.firstname +
                                    //           " " +
                                    //           message.lastname +
                                    //           " :",
                                    //       style: TextStyle(
                                    //           fontSize: 15,
                                    //           color: Colors.blue[900]),
                                    //     ),
                                    // ],
                                    Text(
                                      message.text,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    autofocus: false,
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade100),
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Type your message here...',
                      filled: true,
                      fillColor: Colors.indigo.shade100,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade100),
                          borderRadius: BorderRadius.circular(25)),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.indigo),
                        child: IconButton(
                          onPressed: () {
                            final message = Message(
                                text: _controller.text,
                                date: DateTime.now(),
                                isSentByMe: true);
                            if (_controller.text.isNotEmpty) {
                              setState(() {
                                messages.add(message);
                                News_Service.saveNews(
                                    _controller.text, context);
                              });

                              _controller.clear();

                              // setState(() {
                              //   var data;
                              //   WidgetsBinding.instance!
                              //       .addPostFrameCallback((_) async {
                              //     data = await News_Service.getallnews(context);
                              //     dataliste = data;
                              //   });
                              //   print(dataliste.length);
                              // });

                            }
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // onSubmitted: (text) {
                    //   final message =
                    //       Message(text: text, date: DateTime.now(), isSentByMe: true);

                    //   setState(() {
                    //     messages.add(message);
                    //     text = "";
                    //   });
                    // },
                  ),
                )
              ],
            ),
    );
  }
}

class Message {
 // String? firstname;
 // String? lastname;
  String? id;
  String? data;
  String text;
  DateTime date;
  bool isSentByMe;
  Message(
      {required this.text,
      required this.date,
      required this.isSentByMe,
      this.id,
      this.data,
     // this.firstname,
   //   this.lastname
      }
      );
}
