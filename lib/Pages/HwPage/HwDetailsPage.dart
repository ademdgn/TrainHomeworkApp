import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackinghwapp/Pages/HomePage/HomePage_Logic.dart';
import 'package:trackinghwapp/Pages/HwPage/Hw_logic.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeworkDetail extends StatefulWidget {
  final assetPath, hwdetails;

  HomeworkDetail({this.assetPath, this.hwdetails});

  @override
  State<HomeworkDetail> createState() => _HomeworkDetailState();
}

class _HomeworkDetailState extends State<HomeworkDetail> {
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
        SizedBox(height: 15.0),
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
        SizedBox(height: 10.0),
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
        SizedBox(height: 20.0),
        Center(
            child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(widget.hwdetails['hwFileTeacherPath']));
          },
          child: Container(
              width: MediaQuery.of(context).size.width - 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xFFF80BCBD)),
              child: const Center(
                  child: Text(
                'Download  Assigment File ',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        )),
        const SizedBox(height: 20.0),
        Center(
            child: InkWell(
          onTap: () {
            if (widget.hwdetails['isSend'] == false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AssigmentLoadDialog(widget.hwdetails['hwId']);
                },
              );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Homework is sent."),
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
            }
          },
          child: Container(
              width: MediaQuery.of(context).size.width - 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xFFF80BCBD)),
              child: const Center(
                  child: Text(
                'Send Assigment',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        )),
        const SizedBox(height: 20.0),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AssigmentLoadDialog extends StatefulWidget {
  final String hwdetail;

  const AssigmentLoadDialog(this.hwdetail, {super.key});

  @override
  _AssigmentLoadDialogState createState() => _AssigmentLoadDialogState();
}

class _AssigmentLoadDialogState extends State<AssigmentLoadDialog> {
  HwController hwController = HwController();
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
    return AlertDialog(
      title: Text('Assigment Send '),
      actions: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: pickFile,
                  child: Text('Select File'),
                ),
                Flexible(
                  child: Text(
                    ' $selectedFileName',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                hwController.uploadStudent(
                    widget.hwdetail, selectedFilePath, selectedFileName);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Send Assigment"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    });
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: Text('Send'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text('Close'),
            ),
          ],
        ),
      ],
    );
  }
}
