import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinpearl_app/service_data/restaurant_data.dart';

import '../cart_page/cart_data.dart';

class RestaurantPageDetail extends StatefulWidget {
  RestaurantServiceSnapshot restaurantServiceSnapshot;
  RestaurantPageDetail({Key? key, required this.restaurantServiceSnapshot}) : super(key: key);

  @override
  State<RestaurantPageDetail> createState() => _RestaurantPageDetailState();
}

class _RestaurantPageDetailState extends State<RestaurantPageDetail> {
  RestaurantServiceSnapshot? restaurantServiceSnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.36,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: restaurantServiceSnapshot!.restaurantService.anh.map((item) {
                        return Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: Image.network(
                              item,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(child: Container()), // To align the title to the center, you can use an Expanded widget
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Giá
                        Expanded(
                          flex: 4,
                          child: Text("${restaurantServiceSnapshot!.restaurantService.gia} vnđ", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 18),)),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.orangeAccent,),
                              Text(restaurantServiceSnapshot!.restaurantService.xepLoai, style: const TextStyle(fontSize: 16),)
                          ],
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      restaurantServiceSnapshot!.restaurantService.tenDV,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone_rounded),
                        SizedBox(width: 5,),
                        Text(restaurantServiceSnapshot!.restaurantService.sdt, style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/images/maps-and-flags.png", width: 20,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(restaurantServiceSnapshot!.restaurantService.diaChi, style: TextStyle(fontSize: 16),))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(restaurantServiceSnapshot!.restaurantService.moTa, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,)
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final cartProvider = Provider.of<CartData>(context, listen: false);

                      if(!cartProvider.isInCart(restaurantServiceSnapshot)){
                        cartProvider.addItemToCart(restaurantServiceSnapshot);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Đã thêm vào giỏ hàng')
                            )
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Dịch vụ đã có trong giỏ hàng')
                            )
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add to cart ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Icon(Icons.navigate_next_outlined,)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      primary: Colors.orange[300],
                      minimumSize: Size(220, 60),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    restaurantServiceSnapshot = widget.restaurantServiceSnapshot;
  }
}
