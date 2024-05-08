import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:vinpearl_app/auth.dart';
import 'package:vinpearl_app/cart_page/cart_page.dart';
import 'package:vinpearl_app/page_detail/page_popular_service_detail.dart';
import 'package:vinpearl_app/page_profile/page_profile.dart';
import 'package:vinpearl_app/page_search/search_page.dart';
import 'package:vinpearl_app/service_data/resort_data.dart';
import 'package:vinpearl_app/service_page/meeting_page.dart';
import 'package:vinpearl_app/service_page/page_golf.dart';
import 'package:vinpearl_app/service_page/page_resort.dart';
import 'package:vinpearl_app/service_page/page_restaurant.dart';
import 'package:vinpearl_app/your_bill_page/your_bill.dart';

import '../cart_page/cart_data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final  User? user = Auth().currentUser;

  Future<void> signOut() async{
    await Auth().signOut();
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }

  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton(){
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('Sign Out')
    );
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage(),));
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
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),

      //drawer
      drawer: Drawer(
        width: 280,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           DrawerHeader(
             padding: EdgeInsets.zero,
             child: Container(
               color: Colors.orangeAccent,
               child: Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     CircleAvatar(
                       child: Text(user!.email!.substring(0,1), style: const TextStyle(fontSize: 30),),
                       backgroundColor: Colors.deepPurple,
                       maxRadius: 30,
                     ),
                     _userUid(),
                   ],
                 ),
               ),
             ),
           ),

            ListTile(
              leading:  Icon(Icons.person_outline),
              title:  Text('Profile', style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfilePage(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Your Bill', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Setting', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Xử lý khi người dùng chọn mục cai dat
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Log Out', style: TextStyle(fontSize: 16)),
              onTap: () {
                signOut();
                // Xử lý khi người dùng chọn mục log out
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage(),)
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.search,
          color: Colors.white,
          size: 40,
        ),),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text("VINPEARL", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),),
              const Text("Booking your tour", style: TextStyle(fontSize: 25),),
              const SizedBox(height: 35,),

              const SizedBox(height: 40,),
              const Text("Categories", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

              Container(
                padding: const EdgeInsets.only(top: 25.0, bottom: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ResortPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/resort.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Resort", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RestaurantPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/restaurant.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Restaurant", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GolfPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/golf.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Golf", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MeetingPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/meeting-room.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Meeting", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Text("Popular", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

              const SizedBox(height: 30,),

              StreamBuilder<List<ResortServiceSnapshot>>(
                stream: ResortServiceSnapshot.listResortService(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text("Lỗi hiển thị", style: TextStyle(color: Colors
                          .red),),
                    );
                  }
                  else if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var list = snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.7,
                        mainAxisSpacing: 25,
                      ),
                      // itemCount: popularServic`es.length,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PopularServiceDetail(resortServiceSnapshot: list[index],),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // name Service
                                        Expanded(
                                          child: Text(
                                            list[index].resortService!.tenDV,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue
                                            ),
                                          ),
                                        ),

                                        //Phone number
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_outlined, size: 22,
                                              ),
                                              Text(list[index].resortService.sdt,style: const TextStyle(fontSize: 16),)
                                            ],
                                          ),
                                        ),

                                        // address
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/maps-and-flags.png",
                                                width: 22,),
                                              Expanded(
                                                  child: Text(list[index].resortService!.diaChi,
                                                    style: const TextStyle(fontSize: 16),
                                                    overflow: TextOverflow.ellipsis,))
                                            ],
                                          ),
                                        ),

                                        // rating
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star, size: 22),
                                              Text(list[index].resortService!.xepLoai,
                                                  style: const TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                        "${list[index].resortService.anh[0]}",
                                        height: 200,
                                        fit: BoxFit.cover)
                                ),
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
            ],
          ),
        ),
      ),
    );
  }
}


