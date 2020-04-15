import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = '';
  String time = '';
  String flag = '';
  String url  = '';
  bool isDayTime;

  WorldTime({this.location, this.url});

  Future<void> getTime() async{

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map responseJson = jsonDecode(response.body);

      String dateTime = responseJson['datetime'];
      String offset = responseJson['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    } catch(e) {
      print('error - $e');
      time = 'could not get time data';

    }



  }

}