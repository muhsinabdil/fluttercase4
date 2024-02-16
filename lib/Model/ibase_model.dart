abstract class IBaseModel<T> {
  //t tipinde değer alır

  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
  //t tipindedeğer dönecek
}
