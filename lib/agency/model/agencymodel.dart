class AgencyRegModel {
  String name;
  String contactNo;
  String state;
  String city;
  String licence;
  String email;
  String password;
  bool terms;
  DateTime createdAt;
  String? authUid;

  AgencyRegModel({
    required this.name,
    required this.contactNo,
    required this.state,
    required this.city,
    required this.licence,
    required this.email,
    required this.password,
    required this.terms,
    required this.createdAt,
     this.authUid = "",
  });

  // Convert model to a map for Firestore
  Map<String, dynamic> tojson() {
    return {
      "Name": name,
      "ContactNo": contactNo,
      "State": state,
      "City": city,
      "Licence": licence,
      "Email": email,
      "Password": password,
      "Terms": terms,
      "createdAt": createdAt,
      "AuthUid" : authUid
    };
  }
  // factory AgencyRegModel.fromJson(Map<String,dynamic>json){
  //   return AgencyRegModel(
  //     name: json ["Name"],
  //     contactNo: json ["ContactNo"],
  //     state: json ["State"],
  //     city: json ["City"],
  //     licence: json ["Licence"],
  //      email: json ["Email"],
  //      password: json ["Password"],
  //      terms: json ["Terms"],
  //      createdAt: json ["createdAt"],
  //      authUid: json ["AuthUid"]
  //   );
  // }
}
