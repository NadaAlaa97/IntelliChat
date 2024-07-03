import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/My_theme.dart';

class FeaturesBox extends StatelessWidget {
  final Color color;
  final String title;
  final String text;
  const FeaturesBox({super.key, required this.color, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15).copyWith(
          left: 15
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(fontFamily: 'Cera Pro',
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                text,
                style: TextStyle(fontFamily: 'Cera Pro',
                    color:Colors.black,
                ),),
            )
          ],
        ),
      ),
    );
  }
}
