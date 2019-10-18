import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

typedef OnlineStatusCallback = void Function(bool status);

///Displays a non-dismissible overlay on its [child] widget when app is offline.
///
///When app is online, automatically dismisses the overlay.
class MaterialDisplayConnectionStatusOverlayWidget extends StatefulWidget {
  ///The child widget on top of which the overlay will appear.
  final Widget child;

  ///Controls if the internet checking is enabled or not.
  ///
  ///If [isEnabled] is false, this widget does not do anything, regardless of internet connectivity.
  final bool isEnabled;

  ///Sets the frequency of checking the status.
  ///
  ///Default duration is every 3 seconds.
  final Duration frequency;

  ///Widget to display as overlay on top of [child]
  ///
  ///If not provided, a default overlay will be used
  final Widget offlineStatusIndicatorWidget;

  ///Sets the opacity of the overlay's background (scrim).
  ///
  ///If not provided, a default opacity of 0.6 is used.
  final double scrimOpacity;

  ///If set to `true`, places the overlay vertically on top of the screen.
  ///
  ///Otherwise the overlay appears at the bottom of the screen.
  final bool shouldBeOnTop;

  ///Sets the animation duration for the overlay show/hide.
  final Duration animationDuration;

  ///Sets the URL to try to connect to. If URL can be contacted, the connection status is assumed to be online.
  ///
  ///If this URL is not reachable, the app is assumed to be offline. By default, Google is used.
  final String url;

  ///Callback to invoke when the status changes.
  ///
  ///Provides the `status` boolean which represents if the app is now online or not.
  final OnlineStatusCallback onStatusChanged;

  ///Creates a MaterialDisplayConnectionStatusOverlayWidget.
  ///
  ///A [child] widget is required.
  ///Other fields are optional.
  ///Displays a default overlay widget if [offlineStatusIndicatorWidget] is not provided.
  MaterialDisplayConnectionStatusOverlayWidget(
      {this.child,
      this.isEnabled = true,
      this.frequency = const Duration(seconds: 3),
      this.scrimOpacity = 0.6,
      this.shouldBeOnTop = false,
      this.url = 'www.google.com',
      this.animationDuration = const Duration(milliseconds: 200),
      this.onStatusChanged,
      this.offlineStatusIndicatorWidget =
          const DefaultOfflineStatusIndicatorWidget()});
  @override
  _MaterialDisplayConnectionStatusOverlayWidgetState createState() =>
      _MaterialDisplayConnectionStatusOverlayWidgetState();
}

class _MaterialDisplayConnectionStatusOverlayWidgetState
    extends State<MaterialDisplayConnectionStatusOverlayWidget> {
  bool isConnected = true;
  @override
  void initState() {
    super.initState();
    if (widget.isEnabled) {
      GestureDetector();
      Timer.periodic(widget.frequency, checkIfURLAvailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Quicksand'),
        home: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: Stack(
              alignment: widget.shouldBeOnTop
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              children: [
                widget.child,
                IgnorePointer(
                  ignoring: isConnected,
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    color: isConnected
                        ? Colors.transparent
                        : Colors.black.withOpacity(widget.scrimOpacity),
                  ),
                ),
                if (!isConnected)
                  SafeArea(
                    child: widget.offlineStatusIndicatorWidget,
                  )
              ]),
        ));
  }

  void checkIfURLAvailable(Timer timer) async {
    bool latestStatus = isConnected;
    try {
      final result = await InternetAddress.lookup(widget.url)
          .timeout(Duration(seconds: 5), onTimeout: () {
        setState(() {
          isConnected = false;
          return [];
        });
      });
      if (result.isEmpty) {
        setState(() {
          isConnected = false;
        });
      }
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          latestStatus = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        latestStatus = false;
      });
    }
    if (latestStatus != isConnected && widget.onStatusChanged != null) {
      widget.onStatusChanged(latestStatus);
    }
    setState(() {
      isConnected = latestStatus;
    });
  }
}

class DefaultOfflineStatusIndicatorWidget extends StatelessWidget {
  const DefaultOfflineStatusIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Waiting for internet connection',
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Unable to connect to the internet. Please ensure that you are online, and we will automatically restore this app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}