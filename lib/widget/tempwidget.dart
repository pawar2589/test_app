import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Container(
      margin: const EdgeInsets.only(right: 18),
      width: 90,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
            )
          ],
          color: Colors.blueAccent.shade100,
          borderRadius: BorderRadius.circular(16)),
      child: const Column(
        children: [
          Text(
            "14 C",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            "",
            // DateFormat().format(nextSevenDays[index]),
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
