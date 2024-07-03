import 'package:flutter/material.dart';

import '../My_theme.dart';

class SlideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 30,
                  color: MyTheme.lightPink
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.dark_mode,color:MyTheme.lightPink ,size: 25,),
              ),
              Text('Dark Mode', style: TextStyle(
                fontFamily: 'Cera Pro',
                color: MyTheme.lightPink,
                fontSize: 25
              ),),

            ],
          )
        ],
      )
    );
  }
}
