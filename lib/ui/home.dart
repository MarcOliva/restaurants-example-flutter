import 'package:flutter/material.dart';
import 'package:flutter_app_eb/helpers/http_helper.dart';
import 'package:flutter_app_eb/models/restaurant.dart';
import 'package:flutter_app_eb/ui/add_review.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget();

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HttpHelper httpHelper;
  List<Restaurants> restaurants;
  bool loading;
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Barra de búsqueda');

  @override
  void initState() {
    httpHelper = HttpHelper();
    restaurants = List();
    loading = false;
    super.initState();
  }

  Future<List> searchResturants(String restaurant) async {
    setState(() {
      loading = true;
    });
    await httpHelper.getAllRestaurantsByName(restaurant).then((value) {
      setState(() {
        restaurants = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String text) {
                        searchResturants(text);
                      },
                    );
                  } else {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text('Barra de búsqueda');
                    //Listamos los datos por defecto
                    restaurants = List();
                  }
                });
              },
            )
          ],
        ),
        body: Body());
  }

  Widget Body() {
    if (loading) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (restaurants != null) {
      if (restaurants.length < 0) {
        return Center(
          child: const Text("No existen datos"),
        );
      }
      return ListView.builder(
        itemCount: restaurants == null ? 0 : restaurants.length,
        itemBuilder: (BuildContext context, i) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(restaurants[i].restaurant.name),
              subtitle: Text(restaurants[i].restaurant.location.city),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddReview(restaurants[i].restaurant)),
                );
              },
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text("Realiza una busqueda"),
      );
    }
  }
}
