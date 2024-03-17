import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:trackinghwapp/Model/Homework.dart';
import 'package:trackinghwapp/Pages/HwPage/Hw_logic.dart';
import 'package:trackinghwapp/Pages/UserPage/UserPage_Logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HwAddPage extends StatefulWidget {
  const HwAddPage({Key? key}) : super(key: key);

  @override
  State<HwAddPage> createState() => _HwAddPage();
}

class _HwAddPage extends State<HwAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();
  final TextEditingController _HomeworkType = TextEditingController();

  HwController hwController = HwController();
  UserProfile userProfile = UserProfile();

  final List<String> items = [
    'Mobil Programing 1',
    'Mobil Programing 2',
    'Computer Design',
    'Fuzzy Logic',
    'Cloud Computing',
  ];
  String? selectedValue;

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
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: Container(
          margin: EdgeInsets.all(10),
          width: 10,
          height: 10,
          child: Image.asset(
            'assets/5027360.png',
            width: 5,
            height: 5,
          ),
        ),
        title: const Text(
          "Teacher Homework Add",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select Lesson Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                              _HomeworkType.text = value ?? '';
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: double.infinity, // Set width to full width
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.black,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        //Hw Name
                        controller: _nameController,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: " Name"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        //Hw Name
                        controller: _detailsController,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: " Details"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        //hw details
                        controller: _percentController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: " Percent  "),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextField(
                        // Select Bill Pay Date
                        controller: _endDate,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: "Select  End Date",
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _endDate.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                      SizedBox(height: 20),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Validate input fields
                      if (_nameController.text.isEmpty ||
                          _endDate.text.isEmpty ||
                          _detailsController.text.isEmpty ||
                          _percentController.text.isEmpty ||
                          _HomeworkType.text.isEmpty) {
                        // Show an error message or handle the case where any field is empty
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Info"),
                              content:
                                  const Text("Please fill in all the fields."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // All fields are filled, proceed with adding homework
                        Homework hw = Homework(
                          name: _nameController.text,
                          startDate: DateTime.now(),
                          endDate: DateTime.parse(_endDate.text),
                          hwFileTeacherPath: "",
                          hwFileStudentPath: "",
                          details: _detailsController.text,
                          isSend: false,
                          isGrade: false,
                          hwId: '0',
                          sendsName: '',
                          percent: _percentController.text,
                          homeworkName: _HomeworkType.text,
                          grade: '',
                          personId: '',
                        );

                        hwController.addHw(hw, context);
                        hwController.uploadHw(selectedFilePath,
                            selectedFileName, _nameController.text);

                        // Clear input fields
                        _nameController.clear();
                        _endDate.clear();
                        _detailsController.clear();
                        _percentController.clear();
                        _HomeworkType.clear();

                        // Show success message
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Add Homework Successfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: const Icon(
                      Icons.add,
                      size: 32,
                    ),
                    label: const Text(
                      "Homework Add",
                      style: TextStyle(fontSize: 24),
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
