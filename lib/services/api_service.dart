import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://kasimadalan.pe.hu/urunler";

  Future<List<dynamic>> fetchAllProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/tumUrunleriGetir.php"));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['urunler'];
    } else {
      throw Exception("Ürünler alınamadı!");
    }
  }

  Future<void> addToCart(String ad, String resim, String kategori, int fiyat, String marka, int adet, String kullaniciAdi) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sepeteUrunEkle.php"),
      body: {
        "ad": ad,
        "resim": resim,
        "kategori": kategori,
        "fiyat": fiyat.toString(),
        "marka": marka,
        "siparisAdeti": adet.toString(),
        "kullaniciAdi": kullaniciAdi,
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Ürün sepete eklenemedi!");
    }
  }
}
