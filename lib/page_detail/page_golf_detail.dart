import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinpearl_app/service_data/golf_data.dart';

import '../cart_page/cart_data.dart';

class GolfPageDetail extends StatefulWidget {
  GolfServiceSnapshot golfServiceSnapshot;
  GolfPageDetail({Key? key, required this.golfServiceSnapshot}) : super(key: key);

  @override
  State<GolfPageDetail> createState() => _GolfPageDetailState();
}

class _GolfPageDetailState extends State<GolfPageDetail> {
  GolfServiceSnapshot? golfServiceSnapshot;
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
                      items: golfServiceSnapshot!.golfService.anh.map((item) {
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
                          child: Text("${golfServiceSnapshot!.golfService.gia} vnđ", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 22),)),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.orangeAccent,),
                              Text(golfServiceSnapshot!.golfService.xepLoai, style: TextStyle(fontSize: 16, ),)
                            ],
                          )
                        )
                      ],
                    ),

                    SizedBox(height: 10,),

                    Text(
                      golfServiceSnapshot!.golfService.tenDV,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone_rounded),
                        SizedBox(width: 5,),
                        Text(golfServiceSnapshot!.golfService.sdt, style: TextStyle(fontSize: 16),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/images/maps-and-flags.png", width: 20,),
                        SizedBox(width: 5,),
                        Expanded(
                            child: Text(golfServiceSnapshot!.golfService.diaChi, style: const TextStyle(fontSize: 16),))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(Icons.mail_outlined),
                        const SizedBox(width: 5,),
                        Text(golfServiceSnapshot!.golfService.email)
                      ],
                    ),

                    SizedBox(height: 20,),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(golfServiceSnapshot!.golfService.moTa, style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,)
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

                      if(!cartProvider.isInCart(golfServiceSnapshot)){
                        cartProvider.addItemToCart(golfServiceSnapshot);
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
                      }                    },
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
    golfServiceSnapshot = widget.golfServiceSnapshot;
  }
}