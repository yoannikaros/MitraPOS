import 'package:flutter/material.dart';
import '../../core/sql_lite/meja/db_meja.dart';

class Meja {
  int id;
  String nomor;
  Offset posisi;

  Meja({required this.id, required this.nomor, required this.posisi});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomor': nomor,
      'posisiX': posisi.dx,
      'posisiY': posisi.dy,
    };
  }

  static Meja fromMap(Map<String, dynamic> map) {
    return Meja(
      id: map['id'],
      nomor: map['nomor'],
      posisi: Offset(map['posisiX'], map['posisiY']),
    );
  }

  Meja copyWith({int? id, String? nomor, Offset? posisi}) {
    return Meja(
      id: id ?? this.id,
      nomor: nomor ?? this.nomor,
      posisi: posisi ?? this.posisi,
    );
  }
}

class UpdateMejaScreen extends StatefulWidget {
  @override
  _UpdateMejaScreenState createState() => _UpdateMejaScreenState();
}

class _UpdateMejaScreenState extends State<UpdateMejaScreen> {
  List<Meja> mejaList = [];
  Meja? selectedMeja;
  final double gridSize = 80.0;
  bool showGrid = true;

  @override
  void initState() {
    super.initState();
    _loadMeja();
  }

  Future<void> _addMeja(String nomor) async {
    final dbHelper = DatabaseHelper();
    final newMeja = Meja(
      id: 0,
      nomor: nomor,
      posisi: Offset(100, 100),
    );
    final newMejaId = await dbHelper.insertMeja(newMeja.toMap());
    setState(() {
      mejaList.add(newMeja.copyWith(id: newMejaId));
    });
  }

  Future<void> _loadMeja() async {
    final dbHelper = DatabaseHelper();
    final mejaData = await dbHelper.getAllMeja();
    setState(() {
      mejaList = mejaData.map((data) => Meja.fromMap(data)).toList();
    });
  }

  Future<void> _updateMejaPosition(Meja meja) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.updateMeja(meja.id, meja.toMap());
  }

  Offset _snapToGrid(Offset offset) {
    final double snappedX = (offset.dx / gridSize).round() * gridSize;
    final double snappedY = (offset.dy / gridSize).round() * gridSize;
    return Offset(snappedX, snappedY);
  }

  void _toggleGrid() {
    setState(() {
      showGrid = !showGrid;
    });
  }

  void _showAddMejaDialog() {
    final TextEditingController _nomorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Meja Baru'),
          content: TextField(
            controller: _nomorController,
            decoration: InputDecoration(
              labelText: 'Nomor Meja',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final nomor = _nomorController.text.trim();
                if (nomor.isNotEmpty) {
                  _addMeja(nomor);
                }
                Navigator.of(context).pop();
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _onGridTap(Offset tapPosition) {
    if (selectedMeja != null) {
      setState(() {
        final snappedPosition = _snapToGrid(tapPosition);
        selectedMeja = selectedMeja!.copyWith(posisi: snappedPosition);
        _updateMejaPosition(selectedMeja!);
        _loadMeja();
      });

      setState(() {
        selectedMeja = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Meja'),
        actions: [
          IconButton(
            icon: Icon(showGrid ? Icons.grid_off : Icons.grid_on),
            onPressed: _toggleGrid,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMejaDialog(),
        child: Icon(Icons.add),
      ),
      body: GestureDetector(
        onTapDown: (details) {
          _onGridTap(details.localPosition);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
                maxWidth: 2000, // Atur ukuran maksimal area scroll
                maxHeight: 2000,
              ),
              child: Stack(
                children: [
                  if (showGrid)
                    CustomPaint(
                      size: Size.infinite,
                      painter: GridPainter(gridSize: gridSize),
                    ),
                  ...mejaList.map((meja) {
                    return Positioned(
                      left: meja.posisi.dx,
                      top: meja.posisi.dy,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMeja = meja;
                          });
                        },
                        child: Container(
                          width: gridSize,
                          height: gridSize,
                          decoration: BoxDecoration(
                            color: selectedMeja == meja
                                ? Colors.orange
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              meja.nomor,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double gridSize;

  GridPainter({required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}