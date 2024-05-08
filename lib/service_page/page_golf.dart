import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:vinpearl_app/page_detail/page_golf_detail.dart';
import 'package:vinpearl_app/service_data/golf_data.dart';

import '../cart_page/cart_data.dart';
import '../cart_page/cart_page.dart';

class GolfPage extends StatefulWidget {
  const GolfPage({Key? key}) : super(key: key);

  @override
  State<GolfPage> createState() => _GolfPageState();
}

class _GolfPageState extends State<GolfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(child: Text("Vinpearl Golf")),
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
        body: StreamBuilder<List<GolfServiceSnapshot>>(
          stream: GolfServiceSnapshot.listGolfService(),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GolfPageDetail(golfServiceSnapshot: list[index]),));
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
                              flex: 3,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(list[index].golfService.anh[0],width: 400, fit: BoxFit.cover)
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // name Service
                                      Text(
                                        list[index].golfService!.tenDV,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone_rounded),
                                          const SizedBox(width: 5,),
                                          Text(list[index].golfService!.sdt),
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/maps-and-flags.png", width: 20,),
                                          const SizedBox(width: 5,),
                                          Expanded(
                                              child: Text(list[index].golfService!.diaChi, overflow: TextOverflow.ellipsis,))
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          const Icon(Icons.mail_outlined),
                                          const SizedBox(width: 5,),
                                          Text(list[index].golfService!.email)
                                        ],
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
