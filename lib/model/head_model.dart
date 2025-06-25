class HeadModel {
  String name;
  int age;
  String gender;
  String maritalStatus;
  String occupation;
  String samajName;
  String qualification;
  DateTime birthDate;
  String bloodGroup;
  String duties;
  String email;
  String phone;
  String altPhone;
  String landline;
  String socialLink;
  String flat;
  String building;
  String street;
  String landmark;
  String city;
  String district;
  String state;
  String nativeCity;
  String nativeState;
  String country;
  String pincode;
  String temple;

  HeadModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.occupation,
    required this.samajName,
    required this.qualification,
    required this.birthDate,
    required this.bloodGroup,
    required this.duties,
    required this.email,
    required this.phone,
    required this.altPhone,
    required this.landline,
    required this.socialLink,
    required this.flat,
    required this.building,
    required this.street,
    required this.landmark,
    required this.city,
    required this.district,
    required this.state,
    required this.nativeCity,
    required this.nativeState,
    required this.country,
    required this.pincode,
    required this.temple,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "maritalStatus": maritalStatus,
      "occupation": occupation,
      "samajName": samajName,
      "qualification": qualification,
      "birthDate": birthDate.toIso8601String(),
      "bloodGroup": bloodGroup,
      "duties": duties,
      "email": email,
      "phone": phone,
      "altPhone": altPhone,
      "landline": landline,
      "socialLink": socialLink,
      "flat": flat,
      "building": building,
      "street": street,
      "landmark": landmark,
      "city": city,
      "district": district,
      "state": state,
      "nativeCity": nativeCity,
      "nativeState": nativeState,
      "country": country,
      "pincode": pincode,
      "temple": temple,
    };
  }
}