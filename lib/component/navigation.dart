import 'package:flutter/material.dart';
import 'package:mitrapos/view/cashier/cashierPage.dart';
import '../shared/theme.dart';
import '../view/demo/meja_screen.dart';
import '../view/demo/update_meja_screen.dart';
import '../view/select_table/table_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget customSideNav() {
      return Container(
        width: 70, // Lebar navigasi
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                width: 50,
                child:               // Item navigasi
                IconButton(
                  icon: Icon(Icons.point_of_sale, color: currentIndex == 0 ? Colors.white : Colors.grey, size: 29,),
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                decoration: BoxDecoration(
                  color: currentIndex == 0 ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),


              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                width: 50,
                child:               // Item navigasi
                IconButton(
                  icon: Icon(Icons.document_scanner, color: currentIndex == 1 ? Colors.white : Colors.grey, size: 29,),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                decoration: BoxDecoration(
                    color: currentIndex == 1 ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),


              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                width: 50,
                child:               // Item navigasi
                IconButton(
                  icon: Icon(Icons.playlist_add_check_circle_rounded, color: currentIndex == 2 ? Colors.white : Colors.grey, size: 29,),
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
                decoration: BoxDecoration(
                    color: currentIndex == 2 ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),


            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return CashirPage();
        case 1:
          return TbViewPage();
        case 2:
          return CashirPage();
        default:
          return CashirPage();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          customSideNav(), // Navigasi di kiri
          Expanded(
            child: body(), // Konten halaman
          ),
        ],
      ),
    );
  }
}
