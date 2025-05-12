// Assuming your Database.dart and Utils.dart are correctly implemented
import 'package:expensetracker/service/database.dart';
import 'package:expensetracker/utils/utils.dart';

import 'package:expensetracker/view/login_screen.dart';
import 'package:expensetracker/view/show.dart';
import 'package:expensetracker/view/widgets/resuable_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }).catchError((error) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            CustomTextField(
                controller: nameController, hintText: "Enter Your Name"),
            SizedBox(height: 15),
            CustomTextField(
                controller: ageController, hintText: "Enter Your Age"),
            SizedBox(height: 15),
            CustomTextField(
                controller: locationController,
                hintText: "Enter Your location"),
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),

                // foreground (text) color
                backgroundColor: Colors.blueAccent, // background color
              ),
              onPressed: () async {
                String id = randomNumeric(10);
                Map<String, dynamic> employeeInfoMap = {
                  "Name": nameController.text,
                  "Age": ageController.text,
                  "Location": locationController.text,
                  "Id": id,
                };

                try {
                  await DatabaseMethods()
                      .addEmployeeDetails(employeeInfoMap, id);
                  Utils().toastMessage("Employee added successfully.");
                } catch (e) {
                  Utils().toastMessage("Failed to add employee: $e");
                }
              },
              child: Text("Add",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(230, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),

                // foreground (text) color
                backgroundColor: Colors.blueAccent, // background color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeListScreen()),
                );
              },
              child: Text(
                "Get All Employees List",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
