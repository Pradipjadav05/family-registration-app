import 'package:flutter/material.dart';

import '../../model/family_member_model.dart';

class MemberCard extends StatelessWidget {
  final FamilyMember member;
  final VoidCallback? onDelete;
  final bool editable;

  const MemberCard({super.key, required this.member, this.onDelete, this.editable = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(member.photoUrl)),
        title: Text("${member.firstName} ${member.lastName}"),
        subtitle: Text(member.relationToHead),
        trailing: editable
            ? IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        )
            : null,
      ),
    );
  }
}