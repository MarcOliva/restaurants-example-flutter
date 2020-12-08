class Restaurante {
  List<Restaurants> _restaurants;

  Restaurante({List<Restaurants> restaurants}) {
    this._restaurants = restaurants;
  }

  List<Restaurants> get restaurants => _restaurants;
  set restaurants(List<Restaurants> restaurants) => _restaurants = restaurants;

  Restaurante.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        _restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._restaurants != null) {
      data['restaurants'] = this._restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  Restaurant _restaurant;

  Restaurants({Restaurant restaurant}) {
    this._restaurant = restaurant;
  }

  Restaurant get restaurant => _restaurant;
  set restaurant(Restaurant restaurant) => _restaurant = restaurant;

  Restaurants.fromJson(Map<String, dynamic> json) {
    _restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._restaurant != null) {
      data['restaurant'] = this._restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  String _apikey;
  String _id;
  String _name;
  Location _location;
  String _thumb;
  String review;
  Restaurant(
      {String apikey,
        String id,
        String name,
        Location location,
        String thumb,this.review}) {
    this._apikey = apikey;
    this._id = id;
    this._name = name;
    this._location = location;
    this._thumb = thumb;

  }

  String get apikey => _apikey;
  set apikey(String apikey) => _apikey = apikey;
  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Location get location => _location;
  set location(Location location) => _location = location;
  String get thumb => _thumb;
  set thumb(String thumb) => _thumb = thumb;

  Restaurant.fromJson(Map<String, dynamic> json) {
    _apikey = json['apikey'];
    _id = json['id'];
    _name = json['name'];
    _location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    _thumb = json['thumb'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apikey'] = this._apikey;
    data['id'] = this._id;
    data['name'] = this._name;
    if (this._location != null) {
      data['location'] = this._location.toJson();
    }
    data['thumb'] = this._thumb;
    data['review']= this.review;
    return data;
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'review': review,
      'city':location.city
    };
  }

}

class Location {
  String _city;
  int _cityId;

  Location({String city, int cityId}) {
    this._city = city;
    this._cityId = cityId;
  }

  String get city => _city;
  set city(String city) => _city = city;
  int get cityId => _cityId;
  set cityId(int cityId) => _cityId = cityId;

  Location.fromJson(Map<String, dynamic> json) {
    _city = json['city'];
    _cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this._city;
    data['city_id'] = this._cityId;
    return data;
  }
}