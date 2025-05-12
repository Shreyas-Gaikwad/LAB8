import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/service/database.dart';

class EmployeeListScreen extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseMethods.getEmployeeDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No data found"));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              String employeeId = documents[index].id;

              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  title: Text(
                    data['Name'] ?? 'No Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                      "Age: ${data['Age']} | Location: ${data['Location']}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showUpdateDialog(context, employeeId, data);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          databaseMethods.deleteEmployeeDetails(employeeId);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, String employeeId,
      Map<String, dynamic> currentData) {
    TextEditingController nameController =
        TextEditingController(text: currentData['Name']);
    TextEditingController ageController =
        TextEditingController(text: currentData['Age'].toString());
    TextEditingController locationController =
        TextEditingController(text: currentData['Location']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Location"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updatedData = {
                  'Name': nameController.text,
                  'Age': int.parse(ageController.text),
                  'Location': locationController.text,
                };

                databaseMethods
                    .updateEmployeeDetails(employeeId, updatedData)
                    .then((_) {
                  Navigator.of(context).pop();
                });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
