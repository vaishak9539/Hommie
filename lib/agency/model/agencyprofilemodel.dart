// class AgencyProfileModel {
//   String name;
//   String mobileNo;
//   String email;
//   String licence;
//   String city;
//   String state;
//   String imageUrl;

//   AgencyProfileModel({
//     required this.name,
//     required this.mobileNo,
//     required this.email,
//     required this.licence,
//     required this.city,
//     required this.state,
//     required this.imageUrl,
//   });

//   // Factory constructor to convert Firestore snapshot to AgencyModel
//   factory AgencyProfileModel.fromFirestore(Map<String, dynamic> data) {
//     return AgencyProfileModel(
//       name: data['Name'],
//       mobileNo: data['ContactNo'],
//       email: data['Email'],
//       licence: data['Licence'],
//       city: data['City'],
//       state: data['State'],
//       imageUrl: data['imageurl'] ?? '',
//     );
//   }

//   // Convert model to map for uploading/updating to Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'Name': name,
//       'ContactNo': mobileNo,
//       'Email': email,
//       'Licence': licence,
//       'City': city,
//       'State': state,
//       'imageurl': imageUrl,
//     };
//   }
// }
