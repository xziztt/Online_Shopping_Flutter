import 'package:flutter/widgets.dart';
import 'package:flutter_shop/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String token; //token will expire after a while
  DateTime expiry;  
  String userId;

  bool isAuthenticated(){
    if(tokenVal != null){
      return true;
    }
    else{
      return false;
    }
  }

  String get tokenVal{    
    if(expiry != null && expiry.isAfter(DateTime.now()) && token!=null){      //check if the token has expired or not
      return token;
    } 
  }
  Future<void> _auth(String email,String password, String logOrSign) async{
    final endPoint = "https://identitytoolkit.googleapis.com/v1/accounts:$logOrSign?key=AIzaSyCa2mPEg23ptNS7AWob5gpQNzFJRnZ-090";
    try{

      final response = await http.post(endPoint,body: json.encode({

      'email': email,
      'password':password,
      'returnSecureToken':true,

    }));
       if(json.decode(response.body)['error'] != null){ //firebase returns a json with an error in it and not an error code

      throw HttpException(json.decode(response.body)['error']['message']);


       }
       final responseFinal = json.decode(response.body);
       token = responseFinal['idToken'];
       userId = responseFinal['localId'];
       expiry = DateTime.now().add(Duration(seconds: int.parse(responseFinal['expiresIn'],),),); //firebase returns the seconds in which token expires
       notifyListeners();                                                                        //add the expiresIn to the current Time to get the expiry date.
       print(json.decode(response.body));
    }   
    catch(error){
      throw error;
    }
    
   
  }
  Future<void> signUp(String email,String password) async{
    return _auth(email,password,"signUp");
  }

  Future<void> signIn(String email,String password) async{
    return _auth(email,password,"signInWithPassword");
  }
}

