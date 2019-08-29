import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'list_data.dart';

List<String> countryName = List<String>();
List<String> flag = List<String>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://restcountries.eu/rest/v2/all';

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var res = await http.get(url);
    var decodedData = jsonDecode(res.body);

    setState(() {
      for (int i = 0; i < 250; i++) {// some of svg flag wont render in flutter so skip it 
        if (i != 4 &&
            i != 10 &&
            i != 31 &&
            i != 32 &&
            i != 39 &&
            i != 44 &&
            i != 64 &&
            i != 73 &&
            i != 89 &&
            i != 97 &&
            i != 99 &&
            i != 156 &&
            i != 167 &&
            i != 168 &&
            i != 199 &&
            i != 206 &&
            i != 208 &&
            i != 209 &&
            i != 213 &&
            i != 221 &&
            i != 234 &&
            i != 249) {
          countryName.add(decodedData[i]['name'].toString());

          flag.add(decodedData[i]['flag'].toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: GradientAppBar(
        title: Text('CountryInfo'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
      ),
      body: GridView.builder(
        itemCount: countryName.isEmpty ? 0 : 228,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.network(
                        flag[index],
                        height: 100,
                        width: 100,
                        allowDrawingOutsideViewBox: false,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        placeholderBuilder: (BuildContext context) =>
                            new Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  Text(
                    countryName[index],
                    textAlign: TextAlign.end,
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                  )
                ],
              ),
            ),
          );
        },
      ));
}