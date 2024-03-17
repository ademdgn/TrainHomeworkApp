import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackinghwapp/Pages/HomePage/HomePage_Logic.dart';
import 'package:trackinghwapp/Pages/HwPage/Hw_logic.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherHomeworkDetailsPage extends StatefulWidget {
  final assetPath, hwdetails;

  TeacherHomeworkDetailsPage({this.assetPath, this.hwdetails});

  @override
  State<TeacherHomeworkDetailsPage> createState() =>
      _TeacherHomeworkDetailsPage();
}

class _TeacherHomeworkDetailsPage extends State<TeacherHomeworkDetailsPage> {
  String selectedFilePath = '';
  String selectedFileName = '';

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        selectedFilePath = file.path ?? '';
        selectedFileName = file.name ?? ''; // Dosya adını al
      });
    } else {
      // Kullanıcı dosya seçmeyi iptal etti
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = (widget.hwdetails['endDate'] as Timestamp).toDate();
    var day = DateFormat('dd').format(dt);
    var month = DateFormat("MMMM").format(dt);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Homework Details',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        const SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('${widget.hwdetails['homeworkName']}',
              style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF80BCBD))),
        ),
        const SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image.asset(widget.assetPath,
                height: 150.0, width: 100.0, fit: BoxFit.contain)),
        const SizedBox(height: 20.0),
        Center(
          child: Text('${widget.hwdetails['name']}',
              style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF80BCBD))),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text('${widget.hwdetails['details']}',
                style: const TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 15.0)),
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
            child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(widget.hwdetails['hwFileStudentPath']));
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 100.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xFFF80BCBD)),
            child: const Center(
              child: Text(
                'Download Student\'s Homework',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )),
        const SizedBox(height: 20.0),
        Center(
            child: InkWell(
          onTap: () {
            if (widget.hwdetails['isGrade'] == true) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Homework Graded."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  });
            } else {
              _showGradeDialog(context, widget.hwdetails);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 100.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xFFF80BCBD)),
            child: const Center(
              child: Text(
                'Grade The Homework',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )),
        const SizedBox(height: 20.0),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showGradeDialog(BuildContext context, Map<String, dynamic> hwdetails) {
    TextEditingController gradeController = TextEditingController();
    HwController hwController = HwController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Grade'),
          content: TextField(
            controller: gradeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Grade'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                hwController.updatedGrade(
                    hwdetails['hwId'],
                    {"isGrade": true, "grade": gradeController.text},
                    hwdetails['personId']);
                print('Entered Grade: ${gradeController.text}');
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
