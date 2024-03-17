import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackinghwapp/Pages/HwPage/HwDetailsPage.dart';
import 'package:trackinghwapp/Pages/HwPage/TeacherHomeworkDetilsPage.dart';

class HwTeacherCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> hwlist;
  final int index;
  final Color color;

  const HwTeacherCardWidget(this.hwlist, this.index, this.color, {Key? key})
      : super(key: key);

  @override
  State<HwTeacherCardWidget> createState() => _HwTeacherCardWidget();
}

class _HwTeacherCardWidget extends State<HwTeacherCardWidget> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    DateTime dt =
        (widget.hwlist[widget.index]['endDate'] as Timestamp).toDate();
    var day = DateFormat('dd').format(dt);
    var month = DateFormat("MMMM").format(dt);

    String truncatedString = widget.hwlist[widget.index]["name"].length > 14
        ? widget.hwlist[widget.index]["name"].substring(0, 14) + "..."
        : widget.hwlist[widget.index]["name"];
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeacherHomeworkDetailsPage(
                      assetPath: 'assets/computerdesign.jpeg',
                      hwdetails: widget.hwlist[widget.index],
                    )),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.hwlist[widget.index]["sendsName"]}",
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                      SizedBox(width: 5 * fem),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${truncatedString}",
                    style: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10 * fem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5 * fem),
                      Text(
                        '/ $month',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.hwlist[widget.index]["percent"]}%",
                    style: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
