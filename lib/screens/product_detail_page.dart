import 'package:flutter/material.dart';
import '../services/global_data.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(product['ad'], style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                "http://kasimadalan.pe.hu/urunler/resimler/${product['resim']}",
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 50, color: Colors.grey);
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['ad'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '₺${product['fiyat']}',
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            SizedBox(height: 16),
            Text(
              "Kategori: ${product['kategori']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Marka: ${product['marka']}",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Sepete ekleme işlemi
                if (!cart.any((item) => item['id'] == product['id'])) {
                  cart.add({...product, 'quantity': 1});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product['ad']} sepete eklendi!")),
                  );
                } else {
                  // Eğer ürün zaten varsa adedini artır
                  final index = cart.indexWhere((item) => item['id'] == product['id']);
                  cart[index]['quantity']++;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product['ad']} miktarı artırıldı!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  "Sepete Ekle",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
