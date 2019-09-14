import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/httpExceptionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer authTimer;

  bool get isAuth{
    return token!=null;
  }

  String get userId {
    return _userId;
  }

  void logout(){
    _token=null;
    _expiryDate=null;
    _userId=null;
    notifyListeners();

    if(authTimer!=null){
      authTimer.cancel();
      authTimer=null;
    }

  }

 void autoLogOut(){
    if(authTimer!=null){
      authTimer.cancel();
      authTimer=null;
    }
 
    final _expiry=_expiryDate.difference(DateTime.now()).inSeconds;
    authTimer=Timer(Duration(seconds: _expiry),logout);

 }


  String get token{
    if(_expiryDate!=null&& _expiryDate.isAfter(DateTime.now())&& _token!=null){
      return _token;
    }
    return _token=null;
  }



  Future<void> _authenticate(String email,String password,String method) async{

    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyB00iTzKbhx-1pDQLGWENyoYipNK1rOv6c";
    try {
      final response = await http.post(url,
          body: json.encode(
              {'email': email, 'password': password, 'returnSecureToken': true}));
       final responseData=json.decode(response.body);

      if(responseData.containsKey('error')&&responseData['error']['message']!=null){
        throw HttpExceptionModel(responseData['error']['message']);
      }

      _token=responseData['idToken'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId=responseData['localId'];

      final  storeData= await SharedPreferences.getInstance();
        var jsonData=json.encode({
        "userId":_userId,
        "expiryDate":_expiryDate.toIso8601String(),
        "authToken":_token,
      });

      storeData.setString("data", jsonData);

      autoLogOut();
      notifyListeners();
    } catch (e) {
      print(e);
      throw(e);
    }

  }


  Future<bool> autoLogin() async{
    SharedPreferences sharedData= await SharedPreferences.getInstance();

    if(!sharedData.containsKey("data")){
      return false;
    }

    final extractedData=json.decode(sharedData.getString("data")) as Map<String,Object>;

    final expiryDate=DateTime.parse(extractedData["expiryDate"]);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }

    _expiryDate=expiryDate;
    _token=extractedData["authToken"];
    _userId=extractedData["userId"];
    notifyListeners();
    autoLogOut();
    return true;


  }


  Future<void> signUp(String email, String password) async {

    return _authenticate(email, password,'signUp');
  }
  Future<void> signIn(String email,String password) async{
    return _authenticate(email, password,'signInWithPassword');
}


}
