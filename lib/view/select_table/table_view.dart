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
  Set<int> selectedMejaIds =
      {}; // Menyimpan ID meja yang dipilih sebagai integer
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

  void _toggleMejaSelection(int mejaId) {
    setState(() {
      if (selectedMejaIds.contains(mejaId)) {
        selectedMejaIds.remove(mejaId);
      } else {
        selectedMejaIds.add(mejaId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Table View',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(showGrid ? Icons.grid_off : Icons.grid_on),
            onPressed: _toggleGrid,
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.pushNamed(context, '/update-meja');
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            // Tambahkan aksi di sini
          },
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              children: [
                // Bagian kiri untuk informasi meja

                Icon(
                  Icons.table_bar,
                  color: Colors.blueAccent,
                  size: 25,
                ),
                SizedBox(width: 8),
                Text(
                  'Table',
                  style: TextStyle(
                      color: selectedMejaIds.isNotEmpty ? Colors.blue : Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  width: 20,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Flexible(
                    child: Text(
                      selectedMejaIds.isNotEmpty
                          ? selectedMejaIds
                              .map((id) => mejaList
                                  .firstWhere((meja) => meja.idTable == id)
                                  .noTable)
                              .join(', ')
                          : 'Tidak ada meja yang dipilih',
                      style: TextStyle(
                          color: selectedMejaIds.isNotEmpty
                              ? Colors.blue
                              : Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                Spacer(),
                // Tombol di sebelah kanan
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
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
                        final isBooked =
                            meja.status == 'booked'; // Periksa status meja

                        final isSelected =
                            selectedMejaIds.contains(meja.idTable);
                        print('Meja ${meja.idTable} isSelected: $isSelected');

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
                                      content: Text(
                                          'Apakah meja ini sudah selesai?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pop(), // Tutup dialog
                                          child: Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog sebelum memproses
                                            try {
                                              // Panggil fungsi API untuk memperbarui status meja
                                              await apiService
                                                  .updateTableStatus(
                                                      meja.idTable,
                                                      'available');
                                              _loadMeja(); // Refresh data meja
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Gagal memperbarui status meja: $e')),
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
                                _toggleMejaSelection(meja.idTable);
                              }
                            },
                            child: Container(
                              width: gridSize,
                              height: gridSize,
                              decoration: BoxDecoration(
                                color: isBooked
                                    ? Colors
                                        .yellow // Warna untuk meja yang sudah dipesan
                                    : isSelected
                                        ? Colors
                                            .green // Warna untuk meja yang dipilih
                                        : Colors
                                            .blue, // Warna default untuk meja lainnya
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.red
                                      : Colors
                                          .white, // Border untuk meja yang dipilih
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
