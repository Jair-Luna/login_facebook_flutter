import 'package:flutter/material.dart';
import 'package:login_facebook_flutter/home_page.dart';
import 'package:login_facebook_flutter/music_library.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color(0xff1c62ed),
        bottom: TabBar(
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 40.0,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.library_music_outlined,
                size: 40.0,
              ),
            ),
          ],
          controller: tabController,
        ),
      ),
      backgroundColor: const Color(0xffc1c9d9),
      body: TabBarView(
        children: const <Widget>[
          HomePage(),
          Library(),
        ],
        controller: tabController,
      ),
    );
  }
}
