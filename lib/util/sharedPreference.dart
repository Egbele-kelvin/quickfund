import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceQS {


  getSharedPrefs(var sharedType, String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(rem);

    switch(sharedType){
      case String:
        var res = prefs.getString(fieldName);
        return res;
      case int:
        return prefs.getInt(fieldName);
      case bool:
        return prefs.getBool(fieldName);
    }

  }

  Future<Null>
  setData(String sharedType, String fieldName, var fieldValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch(sharedType){
      case 'String':
        prefs.setString(fieldName, fieldValue);
        break;
      case 'int':
        prefs.setInt(fieldName, fieldValue);
        break;
      case 'bool':
        prefs.setBool(fieldName, fieldValue);
        break;
    }

  }
}