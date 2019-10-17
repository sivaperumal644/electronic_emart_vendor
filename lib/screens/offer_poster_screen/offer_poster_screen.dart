import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/offer_poster_list_item.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/PosterModel.dart';
import 'package:electronic_emart_vendor/screens/add_poster_screen/add_poster_screen.dart';
import 'package:electronic_emart_vendor/screens/offer_poster_screen/get_offer_poster_graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class OfferPosterScreen extends StatefulWidget {
  @override
  _OfferPosterScreenState createState() => _OfferPosterScreenState();
}

class _OfferPosterScreenState extends State<OfferPosterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
              'Promotions/Offers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'This section allows you to add posters to display to the customer. Create a new poster, and add the items you want to display. ',
              style: TextStyle(
                color: GREY_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.only(top: 24, bottom: 6),
            child: Text(
              'Your posters',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          getOfferPosterQueryComponent(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: PRIMARY_COLOR.withOpacity(0.35)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPosterScreen(),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ADD NEW POSTER',
                    style: TextStyle(
                      color: PRIMARY_COLOR.withOpacity(0.35),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget offerPosterListView(List<PosterModel> posters) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: posters.length,
      itemBuilder: (context, index) {
        print(posters[index].inventory);
        return OfferPosterListItem(
          poster: posters[index],
        );
      },
    );
  }

  Widget getOfferPosterQueryComponent() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getOfferPosterQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading)
          return Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(child: CupertinoActivityIndicator()));
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getPosters'] != null) {
          List posterList = result.data['getPosters'];
          final List<PosterModel> posters =
              posterList.map((poster) => PosterModel.fromJson(poster)).toList();
          return offerPosterListView(posters);
        }
        return Container();
      },
    );
  }
}
