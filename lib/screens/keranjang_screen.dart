import 'package:flutter/material.dart';
import 'checkout_screen.dart'; // Pastikan path ini benar

class KeranjangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  KeranjangItem(
                    imageUrl: 'assets/ramen.jpg',
                    title: 'Ramen',
                    price: 50000,
                  ),
                  KeranjangItem(
                    imageUrl: 'assets/sushi.jpg',
                    title: 'Sushi',
                    price: 60000,
                  ),
                  KeranjangItem(
                    imageUrl: 'assets/udon.jpg',
                    title: 'Udon',
                    price: 55000,
                  ),
                ],
              ),
            ),
            CheckoutSection(),
          ],
        ),
      ),
    );
  }
}

class KeranjangItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;

  KeranjangItem({required this.imageUrl, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.0), // Menambahkan padding di dalam ListTile
        leading: Container(
          width: 90, // Memperbesar lebar gambar
          height: 100, // Memperbesar tinggi gambar
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Meningkatkan ukuran font untuk judul
        ),
        subtitle: Text(
          'Rp $price',
          style: TextStyle(fontSize: 16), // Menyesuaikan ukuran font untuk harga
        ),
      ),
    );
  }
}

class CheckoutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Meningkatkan ukuran font untuk total
              ),
              Text(
                'Rp 165000',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Meningkatkan ukuran font untuk total
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen()),
              );
            },
            child: Text(
              'Checkout',
              style: TextStyle(fontSize: 18), // Meningkatkan ukuran font untuk tombol
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0), // Menambah padding vertikal pada tombol
              backgroundColor: Colors.blue, // Mengatur warna latar belakang tombol
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KeranjangScreen(),
  ));
}
