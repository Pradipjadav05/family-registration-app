import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/family_member_model.dart';
import '../model/head_model.dart';

class DBService {
  final CollectionReference headRef = FirebaseFirestore.instance.collection('family_heads');

  // Save family head (using phone as document ID for uniqueness)
  Future<void> saveFamilyHead(HeadModel head) async {
    await headRef.doc(head.phone).set(head.toJson());
  }

  // Save member under specific head document
  Future<void> saveFamilyMember(String headPhone, FamilyMember member) async {
    final memberCollection = headRef.doc(headPhone).collection('members');
    await memberCollection.add(member.toJson());
  }

  // Get members of a specific head
  Future<List<FamilyMember>> getFamilyMembers(String headPhone) async {
    final memberCollection = headRef.doc(headPhone).collection('members');
    final query = await memberCollection.get();
    return query.docs.map((doc) => FamilyMember.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}
