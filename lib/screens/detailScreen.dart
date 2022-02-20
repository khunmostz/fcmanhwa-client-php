import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_client_fcmanhwa/modals/manhwa_list.dart';
import 'package:flutter_client_fcmanhwa/screens/homeScreen.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<Manhwalist> _manhwalist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Future<List> fetchDataId(String id) async {
    var url = Uri.parse(
        "http://fcmanhwacs322.000webhostapp.com/services/api/get_manhwa_id.php?manh_id=${id}");
    var response = await http.get(url);
    print(response.body);
    _manhwalist = manhwalistFromJson(response.body);
    print(_manhwalist);
    return _manhwalist;
  }

  Future<List> fetchData() async {
    var url = Uri.parse(
        "http://fcmanhwacs322.000webhostapp.com/services/api/get_manhwa_list.php");
    var response = await http.get(url);
    print(response.body);
    _manhwalist = manhwalistFromJson(response.body);
    print(_manhwalist);
    return _manhwalist;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // title: Text("Detail"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: fetchDataId(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List data = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              await fetchData();
              setState(() {});
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Image.network(
                      data[index].manhUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${data[index].manhName}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${data[index].cateId} Rating  ${data[index].manhRating}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "เรื่องย่อ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${data[index].manhDesc}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                            future: fetchData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              List rdata = snapshot.data;
                              return SizedBox(
                                // width: size.width,
                                height: 300,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: rdata.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      id: rdata[index].manhId,
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          width: size.width / 2,
                                          height: 200,
                                          clipBehavior: Clip.hardEdge,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.network(
                                            '${rdata[index].manhUrl}',
                                            // width: 100,
                                            // height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
