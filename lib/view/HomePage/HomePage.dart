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
              'Order',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Menu',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            ),
            Spacer(),
            Container(
              height: 45,
              width: 300,
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.search,color: Colors.grey,),
                    SizedBox(width: 20,),
                    Text('Search for food, drink ',style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            )
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
                        children: [
                          header(),
                        ],
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
