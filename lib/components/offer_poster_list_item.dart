import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/PosterModel.dart';
import 'package:electronic_emart_vendor/screens/add_poster_screen/add_poster_screen.dart';
import 'package:flutter/material.dart';

class OfferPosterListItem extends StatefulWidget {
  final PosterModel poster;

  const OfferPosterListItem({this.poster});
  @override
  _OfferPosterListItemState createState() => _OfferPosterListItemState();
}

class _OfferPosterListItemState extends State<OfferPosterListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
          border: Border.all(
            color: PRIMARY_COLOR.withOpacity(0.35),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPosterScreen(
                isNewPoster: false,
                poster: widget.poster,
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                widget.poster.posterImage,
                width: MediaQuery.of(context).size.width,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.poster.inventory.length.toString() + ' items',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: PRIMARY_COLOR,
                        size: 20,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
