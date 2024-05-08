import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PageSearchDetail extends StatefulWidget {
  var searchData;
  PageSearchDetail({Key? key, required this.searchData}) : super(key: key);

  @override
  State<PageSearchDetail> createState() => _PageSearchDetailState();
}

class _PageSearchDetailState extends State<PageSearchDetail> {
  var searchData;
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
                      items: [
                        "https://cf.bstatic.com/xdata/images/hotel/square600/418142776.webp?k=e313a78bc7c97efe03aa10423cd819b7147c621722bf078b93cf92427594b12c&o=&s=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/37343067.jpg?k=4d1e431b5cb0e40c1c352bc7a7d1c204c57e581ae586fc24a465030cd7f84b2e&o=&hp=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/164416341.jpg?k=73b5d341a6d1e78901defadef918198c456836ce697063502ca79843e6d0ceb2&o=&hp=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/164416368.jpg?k=51d31521358431111c7037d72ee72d715c86c52e68551839efef7438a3ee1628&o=&hp=1"
                        // Add more image URLs here
                      ].map((item) {
                        return Container(
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
                        Text("${searchData['gia']} vnđ", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 17),),
                        const SizedBox(width: 130,),
                        const Icon(Icons.star, size: 16,),
                        const Text("4.5", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      searchData['tenDV'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded),
                        const SizedBox(width: 5,),
                        Text(searchData['sdt'], style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/images/maps-and-flags.png", width: 20,),
                        const SizedBox(width: 5,),
                        Text(searchData['diaChi'], style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,maxLines: 1)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(searchData['moTa'])
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add service to cart logic goes here
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
    searchData = widget.searchData;
    super.initState();
  }
}
