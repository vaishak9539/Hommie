import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgencyRegModel {
  String name = "";
  String contactNo = "";
  String state = "";
  String city = "";
  String licence = "";
  String email = "";
  String password = "";
  bool terms =false;

  String? agencyName(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyContactNo(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyState(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyCity(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyLicence(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyEmail(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  String? agencyPassword(String value) {
    if (value.isEmpty) {
      return "Name is Empty";
    }
    return null;
  }

  Future registerAgency() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          String agencyAuthenticationUid = userCredential.user!.uid;

          await FirebaseFirestore.instance.collection("AgencyCollection").doc(agencyAuthenticationUid).set({
            "Name": name,
            "ContactNo" : contactNo,
            "State" : state,
            "City" : city,
            "Licence" : licence,
            "Email": email,
            "Password" : password,
            "Terms" : terms,
            "createdAt" : Timestamp.now(),
          });
    } catch (e) {
      print("Failed to register : $e");
    }
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String email = '';
//   String password = '';
//   String name = ''; // Additional field for Firestore data

//   // Firebase Authentication instance
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Firestore instance
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Validation methods
//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'Email is required';
//     }
//     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Enter a valid email';
//     }
//     return null;
//   }

//   String? validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     return null;
//   }

//   // Firebase Authentication: Sign up the user
//   Future<User?> signUpUser() async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print('Error signing up: $e');
//       return null;
//     }
//   }

//   // Firebase Firestore: Add user data to Firestore
//   Future<void> addUserToFirestore(User? user) async {
//     if (user != null) {
//       await _firestore.collection('users').doc(user.uid).set({
//         'name': name,
//         'email': email,
//         'createdAt': Timestamp.now(),
//       });
//     }
//   }
// }

