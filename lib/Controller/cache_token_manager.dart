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



enum CacheKey { TOKEN }
