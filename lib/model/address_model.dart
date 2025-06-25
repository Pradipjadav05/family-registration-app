class AddressModel {
  String flat;
  String building;
  String street;
  String landmark;
  String city;
  String district;
  String state;
  String country;
  String pincode;

  AddressModel({
    required this.flat,
    required this.building,
    required this.street,
    required this.landmark,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
  });

  Map<String, dynamic> toJson() {
    return {
      "flat": flat,
      "building": building,
      "street": street,
      "landmark": landmark,
      "city": city,
      "district": district,
      "state": state,
      "country": country,
      "pincode": pincode,
    };
  }
}