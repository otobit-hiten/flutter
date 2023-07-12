import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/widgets/round_container.dart';
import '../utils/app_layout.dart';

class TicketView extends StatelessWidget {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width*0.85,
      height: 200,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("AHM",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
                      Expanded(child: Container()),
                      const RoundContainer(),
                      Expanded(child: Stack(
                        children: [
                          SizedBox(
                            height: 24,
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(10, (index) => const SizedBox(
                                    width: 3,height: 1, child: DecoratedBox(
                                    decoration: BoxDecoration(color: Colors.white),
                                  ),
                                  )),
                                );
                              },
                            ),
                          ),
                          Center(child: Transform.rotate(angle: 1.5, child: Icon(Icons.airplanemode_active, color: Colors.white,))),
                        ]
                      )),
                      const RoundContainer(),
                      Expanded(child: Container()),
                      const Text("CHE",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 100, child: Text("Ahmedabad", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.white))),
                      Text("8H:30M",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.white)),
                      SizedBox(width: 100, child: Text("Chennai",  textAlign:TextAlign.end,  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.white))),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: Colors.orange,
              child:  Row(
                children: [
                  SizedBox(
                    height: 20,
                      width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10) )
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                      return Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        children: List.generate(30, (index) => const SizedBox(
                          width: 5,height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                          ),
                        )),
                      );
                    }
                    ),
                  )),
                  SizedBox(
                    height: 20,
                      width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10) )
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
              ),
              padding: const EdgeInsets.all(16),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("1st May", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
                          Gap(5),
                          Text("Date", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("10:00 AM", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
                          Gap(5),
                          Text("Departure Time", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("24", textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white)),
                          Gap(5),
                          Text("Number",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
