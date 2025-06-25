import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/family_member_model.dart';
class FamilyTreeScreen extends StatefulWidget {
  final String headPhone;
  final String headName;

  const FamilyTreeScreen({super.key, required this.headPhone, required this.headName});

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFamilyTree();
  }

  Future<void> fetchFamilyTree() async {
    final memberDocs = await FirebaseFirestore.instance
        .collection('family_heads')
        .doc(widget.headPhone)
        .collection('members')
        .get();

    final Node headNode = Node.Id(widget.headName);
    graph.addNode(headNode);

    for (var doc in memberDocs.docs) {
      final member = FamilyMember.fromJson(doc.data());
      final Node child = Node.Id("${member.firstName} (${member.relationToHead})");
      graph.addEdge(headNode, child);
    }

    setState(() => isLoading = false);
  }

  Future<void> exportAsPdf() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Image(pw.MemoryImage(image)),
          ),
        ),
      );

      await Printing.sharePdf(bytes: await pdf.save(), filename: 'family_tree.pdf');
    }
  }

  Widget _buildNodeWidget(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    builder
      ..siblingSeparation = (20)
      ..levelSeparation = (30)
      ..subtreeSeparation = (30)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Tree'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportAsPdf,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Screenshot(
        controller: screenshotController,
        child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(50),
          child: GraphView(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            builder: (Node node) => _buildNodeWidget(node.key!.value),
          ),
        ),
      ),
    );
  }
}
