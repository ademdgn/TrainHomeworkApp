import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import '../Model/UserModel.dart';
import '../Pages/Const/Utils.dart';

class Storage {
  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection("Person");

  Storage();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* user */
  String currentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return "null";
    }
  }

  Future<void> addUser(Person person, UserCredential userCredential) async {
    await collectionUser.doc(userCredential.user?.uid).set({
      "name": person.name,
      "email": person.email,
      "password": person.password,
      "userRoll": person.userRoll
    });
  }

  Future<void> updatePerson(Map<String, dynamic> updatedData) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .update(updatedData);
        print('User updated.');
      } catch (error) {
        print("Error: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("User logined error.");
    }
  }

  Future<Map<String, dynamic>> getPerson() async {
    var personId = currentUser();
    Map<String, dynamic>? userList = {};
    var documentSnapshot = await collectionUser.doc(personId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      userList = data;
    } else {
      print('Belge bulunamadı.');
    }
    return userList;
  }

  Future<String?> uploadProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('UserProfilePhoto')
        .child(currentUser())
        .child("profil.png");

    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final downloadURL = await storageRef.getDownloadURL();
      collectionUser.doc(currentUser()).update({"photoUrl": downloadURL});
      return downloadURL;
    } else {
      // Return null or an error message in case of an error.
      return null;
    }
  }

  Future<String?> uploadFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child(DateTime.now().toString() + '.png');

    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } else {
      // Return null or an error message in case of an error.
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getHomeworkHistory() async {
    if (currentUser() != "null") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Homework')
            .where("isSend", isEqualTo: true)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> homeworkdocumnet = querySnapshot.docs;
          List<Map<String, dynamic>> homework = [];

          for (QueryDocumentSnapshot document in homeworkdocumnet) {
            Map<String, dynamic> hwdata =
                document.data() as Map<String, dynamic>;

            homework.add(hwdata);
          }

          return homework;
        } else {
          return [];
        }
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
        return [];
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getHomework() async {
    if (currentUser() != "null") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Homework')
            .where("isSend", isEqualTo: false)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> hwdocuments = querySnapshot.docs;
          List<Map<String, dynamic>> hw = [];

          for (QueryDocumentSnapshot document in hwdocuments) {
            Map<String, dynamic> hwData =
                document.data() as Map<String, dynamic>;

            hw.add(hwData);
          }

          return hw;
        } else {
          return [];
        }
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
        return [];
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> sendsHomework() async {
    try {
      if (currentUser() != "null") {
        CollectionReference personCollection =
            FirebaseFirestore.instance.collection('Person');

        QuerySnapshot personSnapshot = await personCollection
            .where('userRoll', isEqualTo: 'Student')
            .get();

        if (personSnapshot.docs.isNotEmpty) {
          List<Map<String, dynamic>> hw = [];

          for (QueryDocumentSnapshot personDoc in personSnapshot.docs) {
            String personId = personDoc.id;

            // Assuming there is a "Homework" subcollection within each "Person" document
            CollectionReference homeworkCollection =
                personCollection.doc(personId).collection('Homework');

            QuerySnapshot homeworkSnapshot = await homeworkCollection
                .where('isSend',
                    isEqualTo: true) // Adjust based on your actual field name
                .get();

            for (QueryDocumentSnapshot homeworkDoc in homeworkSnapshot.docs) {
              Map<String, dynamic> homeworkData =
                  homeworkDoc.data() as Map<String, dynamic>;
              hw.add(homeworkData);

              print(homeworkData);
            }
          }

          return hw;
        } else {
          return [];
        }
      } else {
        Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
        return [];
      }
    } catch (error) {
      print("Hata: $error");
      Utils.showSnackBar("$error");
      return [];
    }
  }

  Future<void> addHomework(Map<String, dynamic> hwdata) async {
    String currentUserId = currentUser();

    if (currentUserId != "null") {
      try {
        QuerySnapshot personSnapshot =
            await FirebaseFirestore.instance.collection("Person").get();

        for (QueryDocumentSnapshot personDoc in personSnapshot.docs) {
          Map<String, dynamic>? data =
              personDoc.data() as Map<String, dynamic>?;

          // Check if the document has the correct user role and data is not null
          if (data != null && data["userRoll"] == "Student") {
            // Assuming there is a "name" field in the document
            String name = data["name"];

            print(name);
            CollectionReference hwCollection =
                personDoc.reference.collection('Homework');

            DocumentReference reference = await hwCollection.add(hwdata);
            String hwId = reference.id;
            String Id = personDoc.id;

            Map<String, dynamic> data_ = {
              "hwId": hwId,
              "sendsName": name,
              "personId": Id
            };
            await updateHw(hwId, data_, Id);
          }
        }

        //Now add homework to the current user's collection outside the loop
        await collectionUser
            .doc(currentUserId)
            .collection('Homework')
            .add(hwdata);
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<void> deleteHw(String hwId) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(currentUser())
            .collection('Homework')
            .doc(hwId)
            .delete();
        print('Homework deleted successfuly.');
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("User logined error.");
    }
  }

  Future<void> updateHw(
      String HwId, Map<String, dynamic> updatedData, Id) async {
    if (currentUser() != "null") {
      try {
        await FirebaseFirestore.instance
            .collection('Person')
            .doc(Id)
            .collection('Homework')
            .doc(HwId)
            .update(updatedData);
      } catch (error) {
        print("Hata: $error");
        Utils.showSnackBar("$error");
      }
    } else {
      Utils.showSnackBar("Kullanıcı girişinde sıkıntı var.");
    }
  }

  Future<void> uploadFileToFirebase(
      selectedFilePath, selectedFileName, homeworkName) async {
    File file = File(selectedFilePath);

    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/${selectedFileName}');

      UploadTask uploadTask = storageReference.putFile(file);
      final snapshot = await uploadTask;
      await uploadTask.whenComplete(() async {
        print('Dosya yükleme tamamlandı');
        if (snapshot.state == TaskState.success) {
          final downloadURL = await storageReference.getDownloadURL();
          print('Dosya yükleme tamamlandı');

          collectionUser.get().then((querySnapshot) {
            querySnapshot.docs.forEach((personDoc) {
              collectionUser
                  .doc(personDoc.id)
                  .collection('Homework')
                  .get()
                  .then((homeworkSnapshot) {
                homeworkSnapshot.docs.forEach((homeworkDoc) {
                  homeworkDoc.reference
                      .update({"hwFileTeacherPath": downloadURL});
                });
              });
            });
          });
        }
      });
    } catch (error) {
      print('Hata: $error');
      // Hata durumunda gerekli işlemleri yapabilirsiniz.
    }
  }

  Future<void> uploadFileToFirebaseStudent(
      hwId, selectedFilePath, selectedFileName) async {
    File file = File(selectedFilePath);

    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/${selectedFileName}');

      UploadTask uploadTask = storageReference.putFile(file);
      final snapshot = await uploadTask;
      await uploadTask.whenComplete(() async {
        print('Dosya yükleme tamamlandı');
        if (snapshot.state == TaskState.success) {
          final downloadURL = await storageReference.getDownloadURL();
          print('Dosya yükleme tamamlandı');

          collectionUser
              .doc(currentUser())
              .collection('Homework')
              .doc(hwId)
              .update({"hwFileStudentPath": downloadURL, "isSend": true});
        }
      });
    } catch (error) {
      print('Hata: $error');
      // Hata durumunda gerekli işlemleri yapabilirsiniz.
    }
  }
}
