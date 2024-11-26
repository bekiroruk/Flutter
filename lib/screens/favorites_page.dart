import 'package:flutter/material.dart';
import '../services/global_data.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Favorilerim', style: TextStyle(color: Colors.white)),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('Favorilere eklenmiş ürün yok.'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return ListTile(
            leading: Image.network(
              "http://kasimadalan.pe.hu/urunler/resimler/${product['resim']}",
              fit: BoxFit.cover,
            ),
            title: Text(product['ad']),
            subtitle: Text('₺${product['fiyat']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Favorilerden silme işlemi
                setState(() {
                  favorites.removeAt(index); // Listedeki elemanı kaldır
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product['ad']} favorilerden kaldırıldı!")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
