import 'package:flutter/material.dart';

class ReviewImageComponent extends StatefulWidget {
  final List images;

  const ReviewImageComponent({this.images});

  @override
  _ReviewImageComponentState createState() => _ReviewImageComponentState();
}

class _ReviewImageComponentState extends State<ReviewImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (widget.images.length >= 1) reviewImageWidget(widget.images[0]),
        if (widget.images.length >= 2) reviewImageWidget(widget.images[1]),
        if (widget.images.length >= 3) reviewImageWidget(widget.images[2]),
        if (widget.images.length >= 4) reviewImageWidget(widget.images[3]),
        if (widget.images.length >= 5) reviewImageWidget(widget.images[4]),
      ],
    );
  }

  Widget reviewImageWidget(String src) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: Container(
                height: 300,
                width: 1200,
                child: Image.network(
                  src,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 50,
        width: 50,
        child: Image.network(
          src,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
