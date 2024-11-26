import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/global_data.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late Future<List<dynamic>> allProducts; // Tüm ürünler
  List<dynamic> filteredProducts = []; // Filtrelenmiş ürünler

  @override
  void initState() {
    super.initState();
    // API'den ürünleri al ve hem tüm ürünlere hem de filtrelenmiş listeye ata
    allProducts = ApiService().fetchAllProducts();
    allProducts.then((products) {
      setState(() {
        filteredProducts = products; // Tüm ürünler başlangıçta gösterilecek
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
      // Ana Sayfa
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
    }
  }

  void filterProducts(String query) {
    allProducts.then((products) {
      setState(() {
        if (query.isEmpty) {
          filteredProducts = products; // Arama kutusu boşsa tüm ürünleri göster
        } else {
          filteredProducts = products.where((product) {
            final productName = product['ad'].toLowerCase();
            return productName.contains(query.toLowerCase());
          }).toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Anasayfa', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ara",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              onChanged: (query) {
                filterProducts(query); // Kullanıcı metin girdikçe filtreleme
              },
            ),
          ),

          // Ürün Listesi
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    // Detay sayfasına geçiş
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Ürün Resmi
                        Expanded(
                          child: Image.network(
                            "http://kasimadalan.pe.hu/urunler/resimler/${product['resim']}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 50, color: Colors.grey);
                            },
                          ),
                        ),

                        // Ürün Adı ve Fiyatı
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['ad'],
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₺${product['fiyat']}',
                                style: TextStyle(color: Colors.orange, fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        // Favorilere ve Sepete Ekle Butonları
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border, color: Colors.red),
                              onPressed: () {
                                // Favorilere ekleme
                                if (!favorites.any((item) => item['id'] == product['id'])) {
                                  favorites.add(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${product['ad']} favorilere eklendi!")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${product['ad']} zaten favorilerde!")),
                                  );
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Sepete ekleme işlemi
                                final existingProductIndex =
                                cart.indexWhere((item) => item['id'] == product['id']);
                                if (existingProductIndex != -1) {
                                  setState(() {
                                    cart[existingProductIndex]['quantity']++;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${product['ad']} miktarı artırıldı!")),
                                  );
                                } else {
                                  setState(() {
                                    cart.add({...product, 'quantity': 1});
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${product['ad']} sepete eklendi!")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: Text("Sepete Ekle"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Alt Navigasyon Çubuğu
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorilerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sepet',
          ),
        ],
      ),
    );
  }
}
