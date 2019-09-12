import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/httpExceptionModel.dart';

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
    _token=_expiryDate=_userId=null;
    notifyListeners();

    if(authTimer!=null){
      authTimer.cancel();
      authTimer=null;
    }

    print("$_token"+"    $_expiryDate"+"    $_userId");
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



       autoLogOut();
      notifyListeners();
    } catch (e) {
      print(e);
      throw(e);
    }


  }

  Future<void> signUp(String email, String password) async {

    return _authenticate(email, password,'signUp');
  }
  Future<void> signIn(String email,String password) async{
    return _authenticate(email, password,'signInWithPassword');
}


}
