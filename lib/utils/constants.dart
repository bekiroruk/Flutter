class Constants {
  // Base URL
  static const String baseUrl = "http://kasimadalan.pe.hu/urunler";

  // API Endpoints
  static const String getAllProducts = "$baseUrl/tumUrunleriGetir.php";
  static const String addToCart = "$baseUrl/sepeteUrunEkle.php";
  static const String getCartItems = "$baseUrl/sepettekiUrunleriGetir.php";
  static const String removeFromCart = "$baseUrl/sepettenUrunSil.php";

  // Default User
  static const String defaultUser = "kullanici_adi"; // Kendi kullanıcı adınızı belirleyin.
}
