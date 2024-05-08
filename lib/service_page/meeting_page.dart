import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:vinpearl_app/page_detail/page_meeting_detail.dart';
import 'package:vinpearl_app/service_data/meeting_data.dart';

import '../cart_page/cart_data.dart';
import '../cart_page/cart_page.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(child: Text("Meeting & Event")),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -5, end: 0),
                badgeContent: Consumer<CartData>(
                  builder: (context, value, child) {
                    return Text("${value.cartItems.length}");
                  },
                ),
                badgeAnimation: const badges.BadgeAnimation.scale(),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
        body: StreamBuilder<List<MeetingServiceSnapshot>>(
          stream: MeetingServiceSnapshot.listMeetingService(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error);
              return const Center(
                child: Text ("Lỗi hiển thị", style: TextStyle(color: Colors.red),),
              );
            }
            else
            if(!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var list = snapshot.data!;
              return GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                    mainAxisSpacing: 25,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingPageDetail(meetingServiceSnapshot: list[index])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(list[index].meetingService!.anh[0],width: 400, fit: BoxFit.cover)
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          list[index].meetingService!.tenDV,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset("assets/images/theater.png", width: 22,),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                                    ),
                                                    child: const Text("Nhà hát"),
                                                  ),
                                                  Text(list[index].meetingService!.nhaHat)
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset("assets/images/classroom.png", width: 22,),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                                    ),
                                                    child: const Text("Lớp học")),
                                                  Text(list[index].meetingService.lopHoc)
                                                ],
                                              )
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset("assets/images/meeting_u.png", width: 22,),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                                    ),
                                                    child: const Text("Chữ U")),
                                                  Text(list[index].meetingService.chuU)
                                                ],
                                              )
                                            ),
                                            Expanded(
                                                child: Column(
                                                  children: [
                                                    Image.asset("assets/images/da_tiec.png", width: 22,),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(bottom: BorderSide(color: Colors.grey))
                                                      ),
                                                      child: const Text("Dạ tiêc")),
                                                    Text(list[index].meetingService.daTiec)
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                child: Column(
                                                  children: [
                                                    Image.asset("assets/images/dry-martini.png", width: 22,),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(bottom: BorderSide(color: Colors.grey))
                                                      ),
                                                      child: const Text("Cooktail")),
                                                    Text(list[index].meetingService.cooktail)
                                                  ],
                                                )
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          },
        )
    );
  }
}
