import 'package:flutter/material.dart';

class CashirPage extends StatefulWidget {
  const CashirPage({super.key});

  @override
  State<CashirPage> createState() => _CashirPageState();
}

class _CashirPageState extends State<CashirPage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        child: Row(
          children: [
            Text(
              'Toko',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Lina',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 35),
            ),
            Spacer(),
            Container(
              height: 45,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food, drink',
                  hintStyle: TextStyle(color: Colors.grey), // Warna placeholder
                  prefixIcon:
                      Icon(Icons.search, color: Colors.grey), // Ikon pencarian
                  border: InputBorder.none, // Hilangkan garis bawah default
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 20), // Padding konten
                ),
                style: TextStyle(color: Colors.black), // Gaya teks yang diketik
              ),
            )
          ],
        ),
      );
    }

    Widget Category() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Drink',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Food',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            ),
          ],
        ),
      );
    }

    Widget Content() {
      return Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Jumlah kolom dalam grid
            crossAxisSpacing: 5, // Jarak horizontal antar item
            mainAxisSpacing: 2, // Jarak vertikal antar item
            childAspectRatio:
                0.90, // Lebar dan tinggi (lebih tinggi dari sebelumnya)
          ),
          itemCount: 1, // Jumlah item total (sesuaikan dengan data Anda)
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nasi Goreng Ayam $index',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Rp. 5.000.000',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget Cart() {
      return Container(
        padding: EdgeInsets.all(10), // Menambahkan padding agar lebih rapi
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Agar item di-align dengan benar
          children: [
            Container(
              height: 55,
              width: 55,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Expanded(
              // Gunakan Expanded agar elemen lain mengambil ruang tersisa
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nasi Goreng Ayam Telor ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '12x',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Menyelaraskan elemen ke atas
                    children: [
                      // Deskripsi
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Pedas Manis',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal,color: Colors.grey),
                          maxLines: 2, // Membatasi hingga 2 baris
                          overflow: TextOverflow
                              .ellipsis, // Memotong jika terlalu panjang
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Memberikan jarak antara deskripsi dan harga
                      // Harga
                      Container(
                        width: 100, // Ukuran tetap untuk harga
                        alignment:
                            Alignment.centerRight, // Sejajarkan teks ke kanan
                        child: Text(
                          '15.000.000',
                          textAlign: TextAlign.right, // Agar teks sejajar kanan
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget totalCart() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 14),
                ),
                Spacer(),
                Text(
                  'Rp. 200.000',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Tax',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 14),
                ),
                Spacer(),
                Text(
                  '0',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(20, (index) {
                return index % 2 == 0
                    ? Container(width: 18, height: 1, color: Colors.black.withOpacity(0.2))
                    : SizedBox(width: 3);
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 16),
                ),
                Spacer(),
                Text(
                  'Rp. 200.000',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Membuat semua anak memenuhi tinggi Row
                children: [
                  // Grid kiri lebih lebar
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header(),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Category()),
                          Content()
                        ],
                      ),
                    ),
                  ),
                  // Grid kanan lebih kecil
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 50, left: 10, bottom: 5, right: 10),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Cart(),
                                  Cart(),
                                  Cart(),
                                  Cart(),                                  Cart(),
                                  Cart(),
                                  Cart(),
                                  Cart(),
                                ],
                              ), // Konten Cart bisa di-scroll jika melebihi batas
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Tambahkan spasi kecil untuk memisahkan dari totalCart
                          Column(
                            children: [
                              totalCart(),
                              Container(
                                height: 40,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
