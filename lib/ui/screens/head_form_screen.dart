import 'package:family_registration_app/services/auto_link_service.dart';
import 'package:family_registration_app/services/db_service.dart';
import 'package:family_registration_app/ui/screens/member_form_screen.dart';
import 'package:family_registration_app/ui/widgets/custom_textfield.dart';
import 'package:family_registration_app/utils/constants.dart';
import 'package:family_registration_app/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../model/head_model.dart';

class HeadFormScreen extends StatefulWidget {
  final String phone;

  const HeadFormScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<HeadFormScreen> createState() => _HeadFormScreenState();
}

class _HeadFormScreenState extends State<HeadFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController dutiesCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController altPhoneCtrl = TextEditingController();
  final TextEditingController landlineCtrl = TextEditingController();
  final TextEditingController socialLinkCtrl = TextEditingController();

  final TextEditingController flatCtrl = TextEditingController();
  final TextEditingController buildingCtrl = TextEditingController();
  final TextEditingController streetCtrl = TextEditingController();
  final TextEditingController landmarkCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController districtCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController nativeCityCtrl = TextEditingController();
  final TextEditingController nativeStateCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController pincodeCtrl = TextEditingController();

  // Dropdowns
  String gender = Constants.genderOptions.first;
  String maritalStatus = Constants.maritalStatusOptions.first;
  String occupation = Constants.occupations.first;
  String qualification = Constants.qualifications.first;
  String bloodGroup = Constants.bloodGroups.first;
  String samaj = Constants.samajOptions.first;

  DateTime? birthDate;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final head = HeadModel(
      name: nameCtrl.text,
      age: int.tryParse(ageCtrl.text) ?? 0,
      gender: gender,
      maritalStatus: maritalStatus,
      occupation: occupation,
      samajName: samaj,
      qualification: qualification,
      birthDate: birthDate ?? DateTime.now(),
      bloodGroup: bloodGroup,
      duties: dutiesCtrl.text,
      email: emailCtrl.text,
      phone: widget.phone,
      altPhone: altPhoneCtrl.text,
      landline: landlineCtrl.text,
      socialLink: socialLinkCtrl.text,
      flat: flatCtrl.text,
      building: buildingCtrl.text,
      street: streetCtrl.text,
      landmark: landmarkCtrl.text,
      city: cityCtrl.text,
      district: districtCtrl.text,
      state: stateCtrl.text,
      nativeCity: nativeCityCtrl.text,
      nativeState: nativeStateCtrl.text,
      country: countryCtrl.text,
      pincode: pincodeCtrl.text,
      temple: AutoLinkService.getTempleForSamaj(samaj),
    );

    await DBService().saveFamilyHead(head);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MemberFormScreen(headPhone: widget.phone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Head Registration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Profile Summary",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CustomTextField(
                  controller: nameCtrl,
                  label: 'Full Name',
                  validator: Validators.validateRequired),
              CustomTextField(
                  controller: ageCtrl,
                  label: 'Age',
                  keyboardType: TextInputType.number),
              DropdownButtonFormField(
                value: gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: Constants.genderOptions
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => gender = val!),
              ),
              DropdownButtonFormField(
                value: maritalStatus,
                decoration: const InputDecoration(labelText: 'Marital Status'),
                items: Constants.maritalStatusOptions
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) => setState(() => maritalStatus = val!),
              ),
              DropdownButtonFormField(
                value: occupation,
                decoration: const InputDecoration(labelText: 'Occupation'),
                items: Constants.occupations
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
                onChanged: (val) => setState(() => occupation = val!),
              ),
              DropdownButtonFormField(
                value: samaj,
                decoration: const InputDecoration(labelText: 'Samaj Name'),
                items: Constants.samajOptions
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => samaj = val!),
              ),
              DropdownButtonFormField(
                value: qualification,
                decoration: const InputDecoration(labelText: 'Qualification'),
                items: Constants.qualifications
                    .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                    .toList(),
                onChanged: (val) => setState(() => qualification = val!),
              ),
              const SizedBox(height: 20),
              const Text("Personal Info",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1990),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => birthDate = picked);
                },
                validator: (value) =>
                    birthDate == null ? 'Please select birth date' : null,
                controller: TextEditingController(
                    text: birthDate != null
                        ? birthDate!.toLocal().toString().split(' ')[0]
                        : ''),
              ),
              DropdownButtonFormField(
                value: bloodGroup,
                decoration: const InputDecoration(labelText: 'Blood Group'),
                items: Constants.bloodGroups
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (val) => setState(() => bloodGroup = val!),
              ),
              CustomTextField(controller: dutiesCtrl, label: 'Duties'),
              const SizedBox(height: 20),
              const Text("Contact Info",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CustomTextField(
                  controller: emailCtrl,
                  label: 'Email',
                  validator: Validators.validateEmail),
              CustomTextField(
                  controller: altPhoneCtrl, label: 'Alternate Phone'),
              CustomTextField(controller: landlineCtrl, label: 'Landline'),
              CustomTextField(
                  controller: socialLinkCtrl, label: 'Social Media Link'),
              const SizedBox(height: 20),
              const Text("Address",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CustomTextField(controller: flatCtrl, label: 'Flat No'),
              CustomTextField(controller: buildingCtrl, label: 'Building Name'),
              CustomTextField(controller: streetCtrl, label: 'Street'),
              CustomTextField(controller: landmarkCtrl, label: 'Landmark'),
              CustomTextField(controller: cityCtrl, label: 'City'),
              CustomTextField(controller: districtCtrl, label: 'District'),
              CustomTextField(controller: stateCtrl, label: 'State'),
              CustomTextField(controller: nativeCityCtrl, label: 'Native City'),
              CustomTextField(
                  controller: nativeStateCtrl, label: 'Native State'),
              CustomTextField(controller: countryCtrl, label: 'Country'),
              CustomTextField(controller: pincodeCtrl, label: 'Pincode'),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Continue to Add Members"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
