import 'package:flutter_app_eb/models/restaurant.dart';
import 'package:flutter_app_eb/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HttpHelper {

  Future<List<Restaurants>> getAllRestaurantsByName(String restaurantName) async {
    final String upcoming = Utils.BASE_URL + Utils.SEARCH_ENDPOINT+ restaurantName;

    http.Response result =
    await http.get(upcoming, headers: {"user-key": Utils.API_KEY});
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);

      List<Restaurants> rests = jsonResponse["restaurants"].map<Restaurants>((i) => Restaurants.fromJson(i)).toList();
      print("RESTAURANTS");
      //print(jsonResponse["restaurants"]);
      //print(rests[0].restaurant.name);
      return rests;
    } else {
      print(result.body);
      return null;
    }
  }
}
