import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: GestureDetector(
          onTap: (){

          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avt.jpg'),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 1, end: 0),
                badgeAnimation: const badges.BadgeAnimation.scale(),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("VINPEARL", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),),
            Text("Booking your tour", style: TextStyle(fontSize: 25),),
            SizedBox(height: 35,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    // Xóa nội dung của TextField
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // Xóa viền biên của TextField
                ),
                filled: true,
                fillColor: Colors.white, // Màu nền cho TextField
              ),
              onChanged: (value) {
                // Xử lý khi giá trị của TextField thay đổi
              },
            ),

            SizedBox(height: 40,),
            Text("Categories", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

            Container(
              padding: EdgeInsets.only(top: 25.0, bottom: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            // color: Colors.white,
                            child: Image.asset('assets/images/resort.png', width: 50,),
                          ),
                          SizedBox(height: 15,),
                          Text("Resort", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            // color: Colors.white,
                            child: Image.asset('assets/images/restaurant.png', width: 50,),
                          ),
                          SizedBox(height: 15,),
                          Text("Restaurant", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            // color: Colors.white,
                            child: Image.asset('assets/images/golf.png', width: 50,),
                          ),
                          SizedBox(height: 15,),
                          Text("Golf", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            // color: Colors.white,
                            child: Image.asset('assets/images/mountain.png', width: 50,),
                          ),
                          SizedBox(height: 15,),
                          Text("Explorer", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text("Popular", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

            Expanded(
              child: GridView.builder(
                itemCount: 5,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {

                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Vinpearl Luxury Nha Trang")
                                  ],
                                ),
                                Image.network('https://cf.bstatic.com/xdata/images/hotel/square600/418142776.webp?k=a967b3e3002eecca67329a0cb6c8b4b7df27bbfcfef71753c1cd02bab36edeaa&o=', width: 200,)
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(thickness: 1.25,),
                          itemCount: 3)
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
