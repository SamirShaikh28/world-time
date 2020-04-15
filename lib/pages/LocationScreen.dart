import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:world_time/services/WorldTime.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int counter = 0;

  Future<List> responseJson;
  List responseList;

  Future<List> getTimeZone() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone');
      if (response.statusCode == 200) {
        List responseJson = jsonDecode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("choose location- $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    responseJson = getTimeZone();
  }

  void updateTime(index) async{
    WorldTime worldTime = WorldTime(location:  responseList[index].toString().substring(responseList[index].toString().indexOf('/')+1, responseList[index].toString().length), url: responseList[index]);
    await worldTime.getTime();
    Navigator.pop(context,{
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDayTime': worldTime.isDayTime
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose a location'),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder<List>(
          future: responseJson,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              responseList = snapshot.data;
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          updateTime(index);
                        },
                        title: Text(snapshot.data[index].toString().substring(snapshot.data[index].toString().indexOf('/') + 1, snapshot.data[index].toString().length)),
                      ),
                    );
                  });
            }
            return Center(
                child:  SpinKitFadingCircle(
                  color: Colors.blue[900],
                  size: 60.0,
                )
            );
          },
        ));
  }
}
