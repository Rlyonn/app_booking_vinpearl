import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinpearl_app/cart_page/cart_data.dart';
import 'package:vinpearl_app/service_data/meeting_data.dart';

class MeetingPageDetail extends StatefulWidget {
  MeetingServiceSnapshot meetingServiceSnapshot;
  MeetingPageDetail({Key? key, required this.meetingServiceSnapshot}) : super(key: key);

  @override
  State<MeetingPageDetail> createState() => _MeetingPageDetailState();
}

class _MeetingPageDetailState extends State<MeetingPageDetail> {
  MeetingServiceSnapshot? meetingServiceSnapshot;
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
                      items: meetingServiceSnapshot!.meetingService.anh.map((item) {
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
                    Text("${meetingServiceSnapshot!.meetingService.gia} vnđ", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 20),),

                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: const BoxDecoration(
                              border: Border(right: BorderSide(color: Colors.grey))
                          ),
                          child: Text(
                            meetingServiceSnapshot!.meetingService.tenDV,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10,),
                        Row(
                          children: [
                            Image.asset("assets/images/area.png", width: 22, color: Colors.orangeAccent,),
                            const SizedBox(width: 5,),
                            Text(meetingServiceSnapshot!.meetingService.dienTich + "m²", style: const TextStyle(fontSize: 16, color: Colors.orangeAccent),)
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 20,),

                    const Text("Sức chứa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset("assets/images/theater.png", width: 25,),
                              const SizedBox(height: 8,),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey))
                                ),
                                child: const Text("NHÀ HÁT"),
                              ),
                              const SizedBox(height: 8,),
                              Text("${meetingServiceSnapshot!.meetingService.nhaHat}")
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Image.asset("assets/images/classroom.png", width: 25,),
                                const SizedBox(height: 8,),
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                    ),
                                    child: const Text("LỚP HỌC")
                                ),
                                const SizedBox(height: 8,),
                                Text(meetingServiceSnapshot!.meetingService.lopHoc)
                              ],
                            )
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Image.asset("assets/images/meeting_u.png", width: 25,),
                                const SizedBox(height: 8,),
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                    ),
                                    child: const Text("CHỮ U")
                                ),
                                const SizedBox(height: 8,),
                                Text(meetingServiceSnapshot!.meetingService.chuU)
                              ],
                            )
                        ),
                      ],
                    ),

                    const SizedBox(height: 15,),

                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              children: [
                                Image.asset("assets/images/da_tiec.png", width: 25,),
                                const SizedBox(height: 8,),
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                    ),
                                    child: const Text("DẠ TIỆC")
                                ),
                                const SizedBox(height: 8,),
                                Text(meetingServiceSnapshot!.meetingService.daTiec)
                              ],
                            )
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Image.asset("assets/images/dry-martini.png", width: 25,),
                                const SizedBox(height: 8,),
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey))
                                    ),
                                    child: const Text("COOKTAIL")
                                ),
                                const SizedBox(height: 8,),
                                Text(meetingServiceSnapshot!.meetingService.cooktail)
                              ],
                            )
                        ),
                        Expanded(child: Column())   //Để căn đều với 3 Expanded phía trên
                      ],
                    ),

                    const SizedBox(height: 20,),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(meetingServiceSnapshot!.meetingService.moTa, style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,)
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

                      if(!cartProvider.isInCart(meetingServiceSnapshot)){
                        cartProvider.addItemToCart(meetingServiceSnapshot);
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
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      primary: Colors.orange[300],
                      minimumSize: const Size(220, 60),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Add to cart ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Icon(Icons.navigate_next_outlined,)
                      ],
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
    meetingServiceSnapshot = widget.meetingServiceSnapshot;
  }
}