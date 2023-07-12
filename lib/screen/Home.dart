import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/screen/TicketView.dart';
import 'package:ui/widgets/hotel_view.dart';

import '../HotelList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.grey),
                          ),
                          Text("Book Tickets",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24)),
                        ],
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage("assets/image/img_1.png"))),
                      ),
                    ],
                  ),
                  Gap(20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        Gap(10),
                        Text(
                          "Search",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcoming Flights",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      InkWell(
                          onTap: () {},
                          child: Text("More..",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.teal)))
                    ],
                  ),
                ],
              ),
            ),
            Gap(15),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [TicketView(), TicketView()],
              ),
            ),
            Gap(5),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hotels",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      InkWell(
                          onTap: () {},
                          child: Text("More..",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.teal)))
                    ],
                  ),
                ],
              ),
            ),
            Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hotelList.map((e) => HotelView(hotel: e)).toList()
              ),
            ),
            Gap(30),

          ],
        ),
      ),
    );
  }
}
