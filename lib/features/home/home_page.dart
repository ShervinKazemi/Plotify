import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu_rounded,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              CupertinoIcons.bell_fill,
              size: 25,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}