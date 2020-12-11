import 'package:flutter/material.dart';
import 'package:flutter_app_eb/helpers/db_helper.dart';
import 'package:flutter_app_eb/models/restaurant.dart';
import 'package:flutter_app_eb/ui/add_review.dart';

class AllReviews extends StatefulWidget {
  const AllReviews();
  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> with WidgetsBindingObserver {
  DbHelper dbHelper;
  List<Restaurant> restaurants;
  Future<List> getAllReviews() async {
    await dbHelper.openDb();
    dbHelper.getAllReviews().then((value) {
      List<Restaurant> tempRests = List();
      for (var i = 0; i < value.length; i++) {
        var restaurant = Restaurant.fromJson(value[i]);
        tempRests.add(restaurant);
      }
      print(tempRests);

      setState(() {
        restaurants = tempRests;
      });
    });
  }

  Future deleteResturant(Restaurant restaurant) async {
    var result = await dbHelper.deleteReview(restaurant);
    if (result == 1) {
      getAllReviews();
    } else {}
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    dbHelper = DbHelper();
    restaurants = List();
    if (mounted) {
      getAllReviews();
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getAllReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mis Reviews"),
        ),
        body: _bodyStatus());
  }

  Widget _bodyStatus() {
    if (restaurants.isEmpty) {
      return Center(
        child: const Text("No hay reviews registradas"),
      );
    } else {
      return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, i) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(restaurants[i].name),
              subtitle: Text(restaurants[i].review),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteResturant(restaurants[i]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddReview(restaurants[i], "update")),
                      );
                      if (result == "updated") {
                        getAllReviews();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
