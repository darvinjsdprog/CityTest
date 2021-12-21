import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class PageAction {
  final Widget? icon;
  final String name;
  final GestureTapCallback onTap;

  PageAction({required this.name, required this.onTap, this.icon});
}

class View extends StatefulWidget {
  final String title;
  final String viewType;
  final Widget child;
  final GlobalKey? scaffoldKey;
  final bool hasBottomAppBar;
  final bool requiredBackButton;
  final bool centerTitle;

  View(
      {this.scaffoldKey,
      required this.title,
      required this.child,
      this.viewType = 'Ciudades disponibles',
      this.hasBottomAppBar = true,
      this.centerTitle = false,
      this.requiredBackButton = false});

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  void initState() {
    super.initState();
  }

  void _changeBrightness() {
    if (MyApp.themeNotifier.value == ThemeMode.light) {
      MyApp.themeNotifier.value = ThemeMode.dark;
    } else {
      MyApp.themeNotifier.value = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 2,
        centerTitle: widget.centerTitle,
        actions: [
          IconButton(
            icon: Icon(
              MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.brightness_2_sharp
                  : Icons.brightness_5,
            ),
            onPressed: () {
              _changeBrightness();
            },
          ),
        ],
        leading: widget.requiredBackButton
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : IconButton(
                icon: SvgPicture.asset("assets/img/icon_home.svg",
                    height: 25,
                    color: MyApp.themeNotifier.value != ThemeMode.light
                        ? Colors.white
                        : Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              Text(
                widget.viewType,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: widget.child,
      ),
    );
  }
}
