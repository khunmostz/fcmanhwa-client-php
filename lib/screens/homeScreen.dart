import 'package:flutter/material.dart';
import 'package:flutter_client_fcmanhwa/modals/categories.dart';
import 'package:flutter_client_fcmanhwa/modals/manhwa_list.dart';
import 'package:flutter_client_fcmanhwa/screens/detailScreen.dart';
import 'package:splash_screen_view/splash_screen_view.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Manhwalist> _manhwalist;
  late List<Manhwalist> _manhwalistforSearch;
  var selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
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
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List data = snapshot.data;
          // print(data);
          return SingleChildScrollView(
            child: Container(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  "Find Your \nList of FCmanhwa",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          searchField(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    toonList(size, data),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget toonList(Size size, List<dynamic> data) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          fetchData();
        });
      },
      child: Container(
        width: size.width,
        height: size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Catoegories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              categoriesBar(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        id: data[index].manhId,
                                      )),
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              '${data[index].manhUrl}',
                              width: 200,
                              height: 260,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data[index].manhName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Spacer(),
              footer("ลิสต์ประจำวัน", Icon(Icons.arrow_forward_ios)),
              SizedBox(
                height: 10,
              ),
              footer("อันดับ", Icon(Icons.arrow_forward_ios)),
              SizedBox(
                height: 10,
              ),
              footer("ประเภท", Icon(Icons.arrow_forward_ios)),
              SizedBox(
                height: 10,
              ),
              footer("แฟนคลับแปล", Icon(Icons.arrow_forward_ios)),
              SizedBox(
                height: 10,
              ),
              footer("ตั้งค่า", Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ),
      ),
    );
  }

  Widget footer(String text, Icon icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        icon,
      ],
    );
  }

  Align categoriesBar() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    '${categories[index].categoryName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 9.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-1.0, -4.0),
                    blurRadius: 9.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget searchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        // onChanged: (text) {
        //   text = text.toLowerCase();
        //   setState(() {
        //     _manhwalist = _manhwalist.where((element) {
        //       var manhName = element.manhName!.toLowerCase();
        //       return manhName.contains(text);
        //     }).toList();
        //   });
        // },
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
