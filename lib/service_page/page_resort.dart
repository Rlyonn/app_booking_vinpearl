import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:vinpearl_app/cart_page/cart_data.dart';
import 'package:vinpearl_app/cart_page/cart_page.dart';
import 'package:vinpearl_app/page_detail/page_resort_detail.dart';
import 'package:vinpearl_app/service_data/resort_data.dart';

class ResortPage extends StatefulWidget {
  const ResortPage({Key? key}) : super(key: key);

  @override
  State<ResortPage> createState() => _ResortPageState();
}

class _ResortPageState extends State<ResortPage> {
  List<ResortServiceSnapshot> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(child: Text("Resort Service")),
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

        body: StreamBuilder<List<ResortServiceSnapshot>>(
          stream: ResortServiceSnapshot.listResortService(),
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
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context)
                            =>  ResortPageDetail(resortServiceSnapshot: list[index])
                            ,)
                      );
                    },

                    //Container chứ danh sách dịch vụ
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      //Column hiển thị ảnh, tên dịch vụ, số điện thoại,...
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network("${list[index].resortService!.anh[0]}", width: 400, fit: BoxFit.cover),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${list[index].resortService!.tenDV}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone_rounded, color: Colors.blueAccent,),
                                          const SizedBox(width: 5,),
                                          Expanded(
                                            flex: 3,
                                            child: Text("${list[index].resortService!.sdt}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                          ),

                                          const Icon(Icons.star, color: Colors.yellow),
                                          const SizedBox(width: 5,),
                                          Expanded(
                                            flex: 1,
                                            child: Text("${list[index].resortService!.xepLoai}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/maps-and-flags.png", width: 20,),
                                          Expanded(
                                            child: Text("${list[index].resortService!.diaChi}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}