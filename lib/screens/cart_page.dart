import 'package:flutter/material.dart';
import '../services/global_data.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Sepetim', style: TextStyle(color: Colors.white)),
      ),
      body: cart.isEmpty
          ? Center(child: Text('Sepete eklenmiş ürün yok.'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            leading: Image.network(
              "http://kasimadalan.pe.hu/urunler/resimler/${product['resim']}",
              fit: BoxFit.cover,
            ),
            title: Text(product['ad']),
            subtitle: Text('₺${product['fiyat']} • Adet: ${product['quantity']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Miktarı Azalt
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      if (cart[index]['quantity'] > 1) {
                        cart[index]['quantity']--;
                      } else {
                        cart.removeAt(index); // Miktar 1 ise ürünü sepetten kaldır
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${product['ad']} miktarı azaltıldı!")),
                    );
                  },
                ),

                // Miktarı Artır
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      cart[index]['quantity']++;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${product['ad']} miktarı artırıldı!")),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
