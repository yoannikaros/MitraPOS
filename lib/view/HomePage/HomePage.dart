import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(width: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Makanan dan Minuman',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(width: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Makanan dan Minuman',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),            SizedBox(width: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Makanan dan Minuman',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),            SizedBox(width: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Makanan dan Minuman',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),            SizedBox(width: 10,),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: Text(
                'Makanan dan Minuman',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),

          ],
        ),
      );
    }


    Widget Content() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 150,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text('Nasi Goreng ayam',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text('Rp. 5000')
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),

          ],
        ),
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
                    flex: 3,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [header(),SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Category()), Content()],
                      ),
                    ),
                  ),
                  // Grid kanan lebih kecil
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white, // Mengisi penuh ruang flex 2
                      child: Center(child: Text("Grid Kanan")),
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
