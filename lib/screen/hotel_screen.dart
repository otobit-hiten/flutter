import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/model/hotel_list.dart';
import 'package:ui/widgets/hotel_view.dart';

import '../widgets/hotel_view_more.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.blueGrey.shade50,
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: const Row(
                  children: [
                    Text(
                      "Looking for Hotels..",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 30),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children:
                      hotelList.map((e) => HotelViewMore(hotel: e)).toList(),
                ),
              )
            ],
          )),
    );
  }
}
