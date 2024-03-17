import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackinghwapp/Pages/HwPage/HwDetailsPage.dart';

class HwCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> hwlist;
  final int index;
  final Color color;

  const HwCardWidget(this.hwlist, this.index, this.color, {Key? key})
      : super(key: key);

  @override
  State<HwCardWidget> createState() => _HwCardWidget();
}

class _HwCardWidget extends State<HwCardWidget> {
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
                builder: (context) => HomeworkDetail(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${truncatedString}",
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.bold,
                              color: widget.color,
                            ),
                          ),
                        ],
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
                    "${widget.hwlist[widget.index]["homeworkName"]}",
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
                  (widget.hwlist[widget.index]["isGrade"] == true)
                      ? Text(
                          "${widget.hwlist[widget.index]["grade"]} Score",
                          style: TextStyle(
                            fontSize: 22 * ffem,
                            fontWeight: FontWeight.bold,
                            color: widget.color,
                          ),
                        )
                      : Text(
                          "Not Graded",
                          style: TextStyle(
                            fontSize: 22 * ffem,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
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
