import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:vinpearl_app/page_detail/page_restaurant_detail.dart';
import 'package:vinpearl_app/service_data/restaurant_data.dart';

import '../cart_page/cart_data.dart';
import '../cart_page/cart_page.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(child: Text("Restaurant Service")),
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
      body: StreamBuilder<List<RestaurantServiceSnapshot>>(
        stream: RestaurantServiceSnapshot.listRestaurantService(),
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
          }
          else {
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
                      Navigator.push(context, 
                          MaterialPageRoute(
                            builder: (context) => RestaurantPageDetail(
                                restaurantServiceSnapshot: list[index]),));
                    },
                    
                    //Container chứa danh sách các dịch vụ nhà hàng
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
                            flex: 5,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(list[index].restaurantService.anh[0], width: 500, fit: BoxFit.cover)
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // name Service
                                    Expanded(
                                      child: Text(
                                        list[index].restaurantService.tenDV,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/clock.png", width: 20,),
                                          const SizedBox(width: 5,),
                                          Expanded(child: Text(list[index].restaurantService.openingTime, overflow: TextOverflow.ellipsis,))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/maps-and-flags.png", width: 20,),
                                          const SizedBox(width: 5,),
                                          Expanded(
                                              child: Text(list[index].restaurantService.diaChi, overflow: TextOverflow.ellipsis,))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone_rounded),
                                          const SizedBox(width: 5,),
                                          Text(list[index].restaurantService.sdt),
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
                }
            );
          }
        },
      )
    );
  }
}
