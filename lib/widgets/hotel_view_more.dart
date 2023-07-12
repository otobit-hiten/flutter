import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/utils/app_layout.dart';

class HotelViewMore extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelViewMore({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5,vertical:5),
      margin: EdgeInsets.only(right: 10,left: 10),
      width: size.width,
      height:280,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/${hotel['image']}")
                )
            ),
          ),
          Gap(5),
          Text("${hotel['place']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          Gap(5),
          Text("${hotel['destination']}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          Gap(5),
          Text("\$${hotel['price']}/Night", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        ],
      ),
    );
  }
}
