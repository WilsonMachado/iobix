import 'package:flutter/material.dart';

import 'widgets/home_body.dart';
import 'widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              HomeDrawer(),
              HomeBody()  
            ]            
          ),
        ),
      ),
    );
  }
}