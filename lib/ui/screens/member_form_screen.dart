import 'package:flutter/material.dart';
import 'package:family_registration_app/services/db_service.dart';
import 'package:family_registration_app/ui/widgets/custom_textfield.dart';
import 'package:family_registration_app/utils/constants.dart';
import 'package:family_registration_app/utils/validators.dart';

import '../../model/family_member_model.dart';
import 'family_tree_screen.dart';

class MemberFormScreen extends StatefulWidget {
  final String headPhone;

  const MemberFormScreen({super.key, required this.headPhone});

  @override
  State<MemberFormScreen> createState() => _MemberFormScreenState();
}

class _MemberFormScreenState extends State<MemberFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<FamilyMember> _members = [];

  // Controllers
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController middleNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController birthDateCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController dutiesCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController altPhoneCtrl = TextEditingController();
  final TextEditingController landlineCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController socialLinkCtrl = TextEditingController();
  final TextEditingController currentAddressCtrl = TextEditingController();
  final TextEditingController nativeCityCtrl = TextEditingController();
  final TextEditingController nativeStateCtrl = TextEditingController();

  // Dropdowns
  String gender = Constants.genderOptions.first;
  String maritalStatus = Constants.maritalStatusOptions.first;
  String qualification = Constants.qualifications.first;
  String occupation = Constants.occupations.first;
  String bloodGroup = Constants.bloodGroups.first;
  String relation = Constants.  relations.first;

  DateTime? birthDate;

  void _addMember() async {
    if (!_formKey.currentState!.validate()) return;

    final member = FamilyMember(
      firstName: firstNameCtrl.text,
      middleName: middleNameCtrl.text,
      lastName: lastNameCtrl.text,
      birthDate: birthDate ?? DateTime.now(),
      age: int.tryParse(ageCtrl.text) ?? 0,
      gender: gender,
      maritalStatus: maritalStatus,
      qualification: qualification,
      occupation: occupation,
      duties: dutiesCtrl.text,
      bloodGroup: bloodGroup,
      relationToHead: relation,
      photoUrl: '',
      phone: phoneCtrl.text,
      altPhone: altPhoneCtrl.text,
      landline: landlineCtrl.text,
      email: emailCtrl.text,
      socialLink: socialLinkCtrl.text,
      currentAddress: currentAddressCtrl.text,
      nativeCity: nativeCityCtrl.text,
      nativeState: nativeStateCtrl.text,
    );

    await DBService().saveFamilyMember(widget.headPhone, member);

    setState(() {
      _members.add(member);
      _formKey.currentState!.reset();
      birthDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Family Members')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Member Info", style: TextStyle(fontWeight: FontWeight.bold)),
              CustomTextField(controller: firstNameCtrl, label: 'First Name', validator: Validators.validateRequired),
              CustomTextField(controller: middleNameCtrl, label: 'Middle Name'),
              CustomTextField(controller: lastNameCtrl, label: 'Last Name'),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => birthDate = picked);
                },
                validator: (value) => birthDate == null ? 'Please select birth date' : null,
                controller: TextEditingController(text: birthDate != null ? birthDate!.toLocal().toString().split(' ')[0] : ''),
              ),
              CustomTextField(controller: ageCtrl, label: 'Age', keyboardType: TextInputType.number),
              DropdownButtonFormField(
                value: gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: Constants.genderOptions.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => gender = val!),
              ),
              DropdownButtonFormField(
                value: maritalStatus,
                decoration: const InputDecoration(labelText: 'Marital Status'),
                items: Constants.maritalStatusOptions.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (val) => setState(() => maritalStatus = val!),
              ),
              DropdownButtonFormField(
                value: qualification,
                decoration: const InputDecoration(labelText: 'Qualification'),
                items: Constants.qualifications.map((q) => DropdownMenuItem(value: q, child: Text(q))).toList(),
                onChanged: (val) => setState(() => qualification = val!),
              ),
              DropdownButtonFormField(
                value: occupation,
                decoration: const InputDecoration(labelText: 'Occupation'),
                items: Constants.occupations.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                onChanged: (val) => setState(() => occupation = val!),
              ),
              DropdownButtonFormField(
                value: bloodGroup,
                decoration: const InputDecoration(labelText: 'Blood Group'),
                items: Constants.bloodGroups.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                onChanged: (val) => setState(() => bloodGroup = val!),
              ),
              DropdownButtonFormField(
                value: relation,
                decoration: const InputDecoration(labelText: 'Relation to Head'),
                items: Constants.relations.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (val) => setState(() => relation = val!),
              ),
              CustomTextField(controller: dutiesCtrl, label: 'Duties'),
              CustomTextField(controller: phoneCtrl, label: 'Phone'),
              CustomTextField(controller: altPhoneCtrl, label: 'Alternate Phone'),
              CustomTextField(controller: landlineCtrl, label: 'Landline'),
              CustomTextField(controller: emailCtrl, label: 'Email'),
              CustomTextField(controller: socialLinkCtrl, label: 'Social Media Link'),
              CustomTextField(controller: currentAddressCtrl, label: 'Current Address'),
              CustomTextField(controller: nativeCityCtrl, label: 'Native City'),
              CustomTextField(controller: nativeStateCtrl, label: 'Native State'),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMember,
                child: const Text("Add Member"),
              ),
              const SizedBox(height: 20),
              if (_members.isNotEmpty) const Text("Added Members", style: TextStyle(fontWeight: FontWeight.bold)),
              ..._members.map((m) => ListTile(
                title: Text("${m.firstName} ${m.lastName}"),
                subtitle: Text(m.relationToHead),
              )),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FamilyTreeScreen(
                        headPhone: widget.headPhone,
                        headName: "Head Name", // Replace with actual head name if stored/passed
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.family_restroom),
                label: const Text("View Family Tree"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
