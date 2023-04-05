//import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Nelly, What Are You\n Looking for?👀',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Icon(
              CupertinoIcons.calendar_badge_plus,
            ),
          )
        ],
      ),
    );
  }
}
