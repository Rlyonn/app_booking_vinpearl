import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_search_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List allResult = [];
  List resultList = [];
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.addListener(onSearchChanged);
    super.initState();
  }
  onSearchChanged(){
    searchResultList();
  }
  searchResultList(){
    var showResult = [];
    if (searchController.text != "") {
      for (var clientSnapshot in allResult) {
        var tenDV = clientSnapshot['tenDV'].toString().toLowerCase();
        if (tenDV.contains(searchController.text.toLowerCase())) {
          showResult.add(clientSnapshot);
        }
      }
    }
    else {
      showResult = List.from(allResult);
    }
    setState(() {
      resultList = showResult;
    });
  }
  getClientStream() async{
    var resortData = FirebaseFirestore.instance
        .collection('ResortService')
        .orderBy('tenDV')
        .get();
    var golfData = FirebaseFirestore.instance
        .collection('GolfService')
        .orderBy('tenDV')
        .get();
    var restaurantData = FirebaseFirestore.instance
        .collection('RestaurantService')
        .orderBy('tenDV')
        .get();
    var meetingData = FirebaseFirestore.instance
        .collection('MeetingService')
        .orderBy('tenDV')
        .get();

    var results = await Future.wait([
      resortData,
      golfData,
      restaurantData,
      meetingData,
    ]);

    var resortDocs = results[0].docs;
    var golfDocs = results[1].docs;
    var restaurantDocs = results[2].docs;
    var meetingDocs = results[3].docs;
    setState(() {
      allResult = [...resortDocs, ...golfDocs, ...restaurantDocs, ...meetingDocs];
    });
    searchResultList();
  }
  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: searchController,
        ),
      ),
      body: ListView.builder(
        itemCount: resultList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageSearchDetail(searchData: resultList[index]),
                  ),
                );
              },
              child: Column(
                  children: [
                    ListTile(
                      title: Text(resultList[index]['tenDV'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      leading: SizedBox(
                        width: 150,
                        child: Image.network(resultList[index]['anh'][0], fit: BoxFit.cover,),
                      ),
                      subtitle: Text("${resultList[index]['gia']} vnđ"),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ]
              ),
            );
          },
      ),
    );
  }
}
