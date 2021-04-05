
import 'package:shared_preferences/shared_preferences.dart';
class Helper{
static String userLoggedInKey ="USERLOGGEDINKEY";
static setUserLoggedInDetails(bool isLogginIn)async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.setBool(userLoggedInKey, isLogginIn);

}

static Future<bool> getUserLoggedInDetails()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  return preferences.getBool(userLoggedInKey);
}
}