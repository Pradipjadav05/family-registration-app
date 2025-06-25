class FamilyMember {
  String firstName;
  String middleName;
  String lastName;
  DateTime birthDate;
  int age;
  String gender;
  String maritalStatus;
  String qualification;
  String occupation;
  String duties;
  String bloodGroup;
  String relationToHead;
  String photoUrl;
  String phone;
  String altPhone;
  String landline;
  String email;
  String socialLink;
  String currentAddress;
  String nativeCity;
  String nativeState;

  FamilyMember({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.qualification,
    required this.occupation,
    required this.duties,
    required this.bloodGroup,
    required this.relationToHead,
    required this.photoUrl,
    required this.phone,
    required this.altPhone,
    required this.landline,
    required this.email,
    required this.socialLink,
    required this.currentAddress,
    required this.nativeCity,
    required this.nativeState,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": birthDate.toIso8601String(),
      "age": age,
      "gender": gender,
      "maritalStatus": maritalStatus,
      "qualification": qualification,
      "occupation": occupation,
      "duties": duties,
      "bloodGroup": bloodGroup,
      "relationToHead": relationToHead,
      "photoUrl": photoUrl,
      "phone": phone,
      "altPhone": altPhone,
      "landline": landline,
      "email": email,
      "socialLink": socialLink,
      "currentAddress": currentAddress,
      "nativeCity": nativeCity,
      "nativeState": nativeState,
    };
  }

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      qualification: json['qualification'] ?? '',
      occupation: json['occupation'] ?? '',
      duties: json['duties'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      relationToHead: json['relationToHead'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      phone: json['phone'] ?? '',
      altPhone: json['altPhone'] ?? '',
      landline: json['landline'] ?? '',
      email: json['email'] ?? '',
      socialLink: json['socialLink'] ?? '',
      currentAddress: json['currentAddress'] ?? '',
      nativeCity: json['nativeCity'] ?? '',
      nativeState: json['nativeState'] ?? '',
    );
  }

}