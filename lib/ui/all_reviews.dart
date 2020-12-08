import 'package:flutter/material.dart';
import 'package:flutter_app_eb/helpers/db_helper.dart';
import 'package:flutter_app_eb/models/restaurant.dart';
import 'package:flutter_app_eb/ui/add_review.dart';
class AllReviews extends StatefulWidget {
  const AllReviews();
  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  DbHelper dbHelper;
  Future<List> getAllReviews () async {
    await dbHelper.openDb();
    var reviews = await dbHelper.getAllReviews().then((value){
      return value;
    });
    print(reviews);
    return reviews;
  }


  @override
  void initState() {

    dbHelper = DbHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Reviews"),

      ),
      body: FutureBuilder(
        future: getAllReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data.length -1,
              itemBuilder: (BuildContext context, i) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(

                    title: Text(snapshot.data[i]["name"]),
                    subtitle: Text(snapshot.data[i]["review"]),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget> [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            dbHelper.deleteReview(snapshot.data[i]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            var restaurant = Restaurant.fromJson(snapshot.data[i]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddReview(restaurant)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: const Text("No existen datos"),
            );
          }
        },
      ),
    );
  }
}
