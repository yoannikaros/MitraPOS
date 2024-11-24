import 'package:flutter/material.dart';
import 'package:mitrapos/view/demo/update_meja_screen.dart';
import '../../core/sql_lite/meja/db_meja.dart';

class FixedMejaScreen extends StatefulWidget {
  @override
  _FixedMejaScreenState createState() => _FixedMejaScreenState();
}

class _FixedMejaScreenState extends State<FixedMejaScreen> {
  List<Map<String, dynamic>> mejaList = [];

  @override
  void initState() {
    super.initState();
    _loadMeja();
  }

  Future<void> _loadMeja() async {
    final dbHelper = DatabaseHelper();
    final mejaData = await dbHelper.getAllMeja();
    setState(() {
      mejaList = mejaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fixed Meja')),
      body: Stack(
        children: mejaList.map((data) {
          final meja = Meja.fromMap(data);
          return Positioned(
            left: meja.posisi.dx,
            top: meja.posisi.dy,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(meja.nomor, style: TextStyle(color: Colors.white))),
            ),
          );
        }).toList(),
      ),
    );
  }
}
