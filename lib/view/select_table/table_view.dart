import 'package:flutter/material.dart';
import '../../core/api_service/meja/meja_api_service.dart';
import '../../core/models/meja_model/meja_models.dart';

class TbViewPage extends StatefulWidget {
  @override
  _TbViewPageState createState() => _TbViewPageState();
}

class _TbViewPageState extends State<TbViewPage> {
  final ApiService apiService = ApiService();
  List<Meja> mejaList = [];
  Set<String> selectedMejaIds = {}; // Menyimpan ID meja yang dipilih
  final double gridSize = 80.0;
  bool showGrid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMeja();
  }

  Future<void> _loadMeja() async {
    setState(() => isLoading = true);
    try {
      final mejaData = await apiService
          .getTablesByProfileId(1); // Ganti profile_id sesuai kebutuhan
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

  void _toggleGrid() {
    setState(() {
      showGrid = !showGrid;
    });
  }

  void _toggleMejaSelection(String mejaId) {
    setState(() {
      if (selectedMejaIds.contains(mejaId)) {
        selectedMejaIds.remove(mejaId); // Hapus jika sudah dipilih
      } else {
        selectedMejaIds.add(mejaId); // Tambah jika belum dipilih
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Table View: ',
              style: TextStyle(color: Colors.black),
            ),
            Flexible(
              child: Text(
                selectedMejaIds.isNotEmpty
                    ? selectedMejaIds.join(', ')
                    : 'Tidak ada meja yang dipilih',
                style: TextStyle(
                  color: selectedMejaIds.isNotEmpty ? Colors.blue : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(showGrid ? Icons.grid_off : Icons.grid_on),
            onPressed: _toggleGrid,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (!isLoading)
            SingleChildScrollView(
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
                        final isSelected = selectedMejaIds.contains(meja.idTable.toString());
                        final isBooked = meja.status == 'booked'; // Periksa status meja

                        return Positioned(
                          left: meja.posisi.dx,
                          top: meja.posisi.dy,
                          child: GestureDetector(
                            onTap: () {
                              if (isBooked) {
                                // Tampilkan dialog jika meja berstatus "booked"
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Konfirmasi'),
                                      content: Text('Apakah meja ini sudah selesai?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(), // Tutup dialog
                                          child: Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop(); // Tutup dialog sebelum memproses
                                            try {
                                              // Panggil fungsi API untuk memperbarui status meja
                                              await apiService.updateTableStatus(meja.idTable, 'available');
                                              _loadMeja(); // Refresh data meja
                                            } catch (e) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Gagal memperbarui status meja: $e')),
                                              );
                                            }
                                          },
                                          child: Text('Sudah'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Pilih/melepas pilihan jika meja tidak "booked"
                                _toggleMejaSelection(meja.idTable.toString());
                              }
                            },
                            child: Container(
                              width: gridSize,
                              height: gridSize,
                              decoration: BoxDecoration(
                                color: isBooked
                                    ? Colors.yellow // Warna kuning untuk meja "booked"
                                    : Colors.blue,   // Warna biru untuk meja lainnya
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? Colors.red : Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  meja.noTable,
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
