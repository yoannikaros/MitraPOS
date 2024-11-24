import 'package:flutter/material.dart';

import '../../core/api_service/meja/meja_api_service.dart';
import '../../core/models/meja_model/meja_models.dart';

class UpdateMejaScreen extends StatefulWidget {
  @override
  _UpdateMejaScreenState createState() => _UpdateMejaScreenState();
}

class _UpdateMejaScreenState extends State<UpdateMejaScreen> {
  final ApiService apiService = ApiService();
  List<Meja> mejaList = [];
  Meja? selectedMeja;
  final double gridSize = 80.0;
  bool showGrid = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMeja();
  }

  Future<void> _loadMeja() async {
    setState(() => isLoading = true);
    try {
      final mejaData = await apiService.getTablesByProfileId(1); // Ganti profile_id sesuai kebutuhan
      setState(() {
        mejaList = mejaData.map((data) => Meja.fromMap(data)).toList();
      });
    } catch (e) {
      print('Gagal memuat data meja: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data meja: $e')),

      );
    }
    setState(() => isLoading = false);
  }

  Future<void> _addMeja(String nomor) async {
    setState(() => isLoading = true);
    try {
      final newMejaData = {
        "profile_id": 1, // Ganti dengan profile_id sesuai kebutuhan
        "no_table": nomor,
        "posisiX": 100.0,
        "posisiY": 100.0,
        "status": "available",
      };
      final newMeja = await apiService.createTable(newMejaData);
      setState(() {
        mejaList.add(Meja.fromMap(newMeja));
      });
    } catch (e) {
      print('Gagal memuat data meja: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan meja: $e')),
      );
    }
    setState(() => isLoading = false);
  }

  Future<void> _updateMejaPosition(Meja meja) async {
    try {
      final updatedData = {
        "profile_id": meja.profileId,
        "no_table": meja.noTable,
        "posisiX": meja.posisi.dx,
        "posisiY": meja.posisi.dy,
        "status": meja.status,
      };
      await apiService.updateTable(meja.idTable, updatedData);
    } catch (e) {
      print('Gagal memuat data meja: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui posisi meja: $e')),
      );
    }
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

        // Update posisi meja yang dipilih
        selectedMeja = selectedMeja!.copyWith(posisi: snappedPosition);

        // Sinkronisasi mejaList
        int index = mejaList.indexWhere((meja) => meja.idTable == selectedMeja!.idTable);
        if (index != -1) {
          mejaList[index] = selectedMeja!;
        }

        // Simpan posisi baru ke API
        _updateMejaPosition(selectedMeja!);
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
      body: Stack(
        children: [
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (!isLoading)
            GestureDetector(
              onTapDown: (details) {
                // Pastikan meja hanya bisa dipindahkan jika sudah dipilih
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
                      maxWidth: 2000,
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
                                  // Pilih meja jika belum dipilih
                                  if (selectedMeja == meja) {
                                    // Jika meja sudah dipilih, hilangkan seleksi
                                    selectedMeja = null;
                                  } else {
                                    // Pilih meja saat ini
                                    selectedMeja = meja;
                                  }
                                });
                              },
                              child: Container(
                                width: gridSize,
                                height: gridSize,
                                decoration: BoxDecoration(
                                  color: selectedMeja == meja ? Colors.orange : Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    meja.noTable,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )

                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
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
