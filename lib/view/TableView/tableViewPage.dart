import 'package:flutter/material.dart';


class TableViewPage extends StatefulWidget {
  const TableViewPage({super.key});

  @override
  State<TableViewPage> createState() => _TableViewPageState();
}

class _TableViewPageState extends State<TableViewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('data')
      ],
    );
  }
}
