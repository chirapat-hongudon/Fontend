import 'package:flutter/material.dart';
import 'package:project_mobile_app/menu/main/game_page.dart';
import 'package:project_mobile_app/menu/main/setting_page.dart';
import 'package:project_mobile_app/menu/main/LeaderBoard_page.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:project_mobile_app/setting/start_page.dart';

import 'package:project_mobile_app/menu/login/login.dart';
import 'package:project_mobile_app/menu/login/register.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  final tabs = [GamePage(), LeaderBoardPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: tabs,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black.withOpacity(0.9),
            activeColor: Colors.black,
            tabBackgroundColor: Colors.blueAccent,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.sports_esports,
                text: "Game",
              ),
              GButton(
                icon: Icons.emoji_events,
                text: "LeaderBoard",
              ),
              GButton(
                icon: Icons.settings,
                text: "Setting",
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
