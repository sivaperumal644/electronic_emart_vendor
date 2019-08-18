import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  AppState();

  int registerScreen = 1;
  bool isPanSubmitted = false;
  bool isPhotoSubmitted = false;

  void setRegisterScreen(int text) {
    registerScreen = registerScreen + text;
    notifyListeners();
  }
   
  void setIsPanSubmitted(bool text){
    isPanSubmitted = text;
    notifyListeners();
  } 

  void setIsPhotoSubmitted(bool text){
    isPhotoSubmitted = text;
    notifyListeners();
  }

  int get getRegisterScreen => registerScreen;
  bool get getIsPanSubmitted => isPanSubmitted;
  bool get getIsPhotoSubmitted => isPhotoSubmitted;
}
