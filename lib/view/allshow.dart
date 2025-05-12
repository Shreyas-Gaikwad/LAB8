// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expensetracker/service/database.dart';
// import 'package:flutter/material.dart';

// class AllShow extends StatefulWidget {
//   const AllShow({super.key});

//   @override
//   State<AllShow> createState() => _AllShowState();
// }

// class _AllShowState extends State<AllShow> {
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController ageController = new TextEditingController();
//   TextEditingController locationController = new TextEditingController();
//   Stream? employeeStream;

//   getontheload() async {
//     employeeStream = await DatabaseMethods().getEmployeeDetails();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     getontheload();
//   }

//   Widget allEmployeeDetails() {
//     return StreamBuilder(
//       stream: employeeStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot ds = snapshot.data.docs[index];
//             return Container(
//               height: 150,
//               width: 300,
//               margin: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Name: ${ds["Name"]}'),
//                     Text('Age: ${ds["Age"]}'),
//                     Text('Location: ${ds["Location"]}'),
//                     GestureDetector(
//                       onTap: () {
//                         nameController.text = ds["Name"];
//                         ageController.text = ds["Age"];
//                         locationController.text = ds["Location"];
//                         editEmployeeDetails(ds["Id"]);
//                       },
//                       child: Text(
//                         "EDIT",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Future editEmployeeDetails(String id) => showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Update Employee Details'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   controller: ageController,
//                   decoration: InputDecoration(labelText: 'Age'),
//                 ),
//                 TextField(
//                   controller: locationController,
//                   decoration: InputDecoration(labelText: 'Location'),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Map<String, dynamic> updateInfo = {
//                     "Name": nameController.text,
//                     "Age": ageController.text,
//                     "Id": id,
//                     "Location": locationController.text,
//                   };
//                   await DatabaseMethods()
//                       .updateEmployeeDetails(id, updateInfo)
//                       .then((value) {
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 child: Text('Update'),
//               ),
//             ],
//           );
//         },
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("AllShow"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Expanded(child: allEmployeeDetails())],
//         ),
//       ),
//     );
//   }
// }
