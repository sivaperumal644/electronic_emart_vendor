import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class DownloadYourDataScreen extends StatefulWidget {
  @override
  _DownloadYourDataScreenState createState() => _DownloadYourDataScreenState();
}

class _DownloadYourDataScreenState extends State<DownloadYourDataScreen> {
  String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String startDate = DateTime.now().year.toString() +
      '-' +
      DateTime.now().month.toString() +
      '-01';
  bool isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          appBar(),
          Text(
            'Download your data',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              'You can download your data here. Please select the start date and end date of the data you want to download and press the download button.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(height: 20),
          Text(
            'Start Date',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(startDate),
                    firstDate: DateTime(2019),
                    lastDate: DateTime.now(),
                  );
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                  setState(() {
                    startDate = formattedDate;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: PRIMARY_COLOR.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    startDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 30),
          Text(
            'End Date',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(endDate),
                    firstDate: DateTime.parse(startDate),
                    lastDate: DateTime.now(),
                  );
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                  setState(() {
                    endDate = formattedDate;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: PRIMARY_COLOR.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    endDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 30),
          isButtonClicked
              ? Container(
                  margin: EdgeInsets.only(top: 50),
                  child: CupertinoActivityIndicator(),)
              :downloadButton(),
        ],
      ),
    );
  }

  Widget downloadButton() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: PrimaryButtonWidget(
        buttonText: 'Download',
        onPressed: () {
          setState(() {
            isButtonClicked = true;
          });
          downloadYourData();
          
        },
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 16, bottom: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          color: PRIMARY_COLOR,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  void downloadYourData() async {
    final appState = Provider.of<AppState>(context);
    String vendorId = appState.getVendorId;
    
    String url =
        'http://cezhop.herokuapp.com/downloadCSV?vendorId=$vendorId&startDate=$startDate&endDate=$endDate';
    if (await canLaunch(url)) {
      setState(() {
        isButtonClicked = false;
      });
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
