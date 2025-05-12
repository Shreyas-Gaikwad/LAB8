import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    try {
      await _firestore.collection("Employee").doc(id).set(employeeInfoMap);
      print("Employee details added successfully.");
    } catch (e) {
      print("Error adding employee details: $e");
    }
  }

  Stream<QuerySnapshot> getEmployeeDetails() {
    try {
      return _firestore.collection("Employee").snapshots();
    } catch (e) {
      print("Error getting employee details: $e");
      rethrow; // Rethrow to handle this error at a higher level if needed
    }
  }

  Future<void> updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    try {
      await _firestore.collection("Employee").doc(id).update(updateInfo);
      print("Employee details updated successfully.");
    } catch (e) {
      print("Error updating employee details: $e");
    }
  }

  // Method to delete employee details
  Future<void> deleteEmployeeDetails(String id) async {
    try {
      await _firestore.collection("Employee").doc(id).delete();
      print("Employee details deleted successfully.");
    } catch (e) {
      print("Error deleting employee details: $e");
    }
  }
}
