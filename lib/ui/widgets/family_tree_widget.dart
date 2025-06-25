import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import '../../model/family_member_model.dart';

class FamilyTreeWidget extends StatelessWidget {
  final List<FamilyMember> members;

  const FamilyTreeWidget({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    final graph = Graph();
    final builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = (20)
      ..levelSeparation = (30)
      ..subtreeSeparation = (30)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    Map<String, Node> nodes = {};

    for (var member in members) {
      final node = Node.Id(member.firstName);
      nodes[member.firstName] = node;
      graph.addNode(node);
    }

    for (var member in members) {
      if (nodes.containsKey(member.relationToHead)) {
        graph.addEdge(nodes[member.relationToHead]!, nodes[member.firstName]!);
      }
    }

    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        builder: (Node node) {
          return Container(
            padding: const EdgeInsets.all(8),
            color: Colors.lightBlueAccent,
            child: Text(node.key!.value.toString()),
          );
        },
      ),
    );
  }
}
