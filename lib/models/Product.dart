class Product {

  String _urlToImage;
  String _about;
  String _title;
  double _price;
  double _weight;
  String _category;
  int _id;


  Product(this._urlToImage, this._title, this._price, this._weight, this._category,this._about,this._id);


  double get weight => _weight;

  double get price => _price;

  String get title => _title;

  String get urlToImage => _urlToImage;

  String get category =>_category;

  int get id => _id;

  String get about => _about;


}