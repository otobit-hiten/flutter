import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/screen/hotel_screen.dart';
import 'package:ui/model/ticket_list.dart';
import 'package:ui/widgets/ticket_view.dart';
import 'package:ui/widgets/hotel_view.dart';
import '../model/hotel_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Gap(40),
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
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Upcoming Flights",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      InkWell(
                          onTap: () {},
                          child: const Text("More..",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xff6D859E))))
                    ],
                  ),
                ],
              ),
            ),
            const Gap(15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ticketList.map((e) => TicketView(ticket: e)).toList(),
              ),
            ),
            const Gap(5),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Hotels",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HotelScreen()));
                          },
                          child: const Text("More..",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xff6D859E))))
                    ],
                  ),
                ],
              ),
            ),
            const Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: hotelList.map((e) => HotelView(hotel: e)).toList()),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
