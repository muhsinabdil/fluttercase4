import 'package:shared_preferences/shared_preferences.dart';

mixin CacheTokenManager {
  Future<bool> saveToken(String token) async {
    //! gelen token locale kaydedilecek
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        CacheKey.TOKEN.toString(), token); //! TOKEN keyi ile kaydedildi
    return true;
  }
}

Future<String?> getToken() async {
  //! token locale den alınacak
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs
      .getString(CacheKey.TOKEN.toString()); //! TOKEN keyinden value alındı
}

Future<bool> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(CacheKey.TOKEN.toString());
}

enum CacheKey { TOKEN }
