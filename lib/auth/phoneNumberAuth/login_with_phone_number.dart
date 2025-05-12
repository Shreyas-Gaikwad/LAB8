import 'package:expensetracker/auth/phoneNumberAuth/verify_code.dart';
import 'package:expensetracker/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  bool loading = false;
  final phoneNumberController = TextEditingController(text: "+91 ");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;

  void verifyPhoneNumber() async {
    String phoneNumber = phoneNumberController.text.trim();

    if (phoneNumber.length <= 4) {
      Utils().toastMessage("Please enter a valid phone number.");
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Utils().toastMessage(
              "Phone number automatically verified and user signed in.");
        },
        verificationFailed: (FirebaseAuthException e) {
          Utils().toastMessage("Verification Failed: ${e.message}");
          setState(() {
            loading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            loading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifyCodeScreen(verificationId: _verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Utils().toastMessage("Verification Code Timeout: $verificationId");
          setState(() {
            loading = false;
          });
        },
      );
    } catch (e) {
      Utils().toastMessage("Failed to verify phone number: $e");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+91 1234567890',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 50),
            Center(
              child: loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(230, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: verifyPhoneNumber,
                      child: Text(
                        "Get Your OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
