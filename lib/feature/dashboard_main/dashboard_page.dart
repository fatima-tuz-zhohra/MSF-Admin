
import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

import 'dashbord_panel_screen.dart';
import 'dashboard_category_view.dart';
import 'main_navigation.dart';

class DashboardScreen extends StatefulWidget {
   DashboardScreen({Key? key}) : super(key: key);
  static const ROUTE = "/home";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: MainNavigation()),
      body: MsfAdminBasePageLayout(
        child:
            SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(title: 'Medical Support Finder',
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(value: _switchValue, onChanged: (value){
                            setState((){
                              _switchValue = value;
                            });
                          }),
                          Text('Dark Mode'),
                        ],
                      ),
                    )
                  ],),
                  Text("Hello, "),
                  Text('Welcome to your dashboard'),
                  SizedBox(height: 16),
                  DashboardPanelScreen(),
                  SizedBox(height: 16),
                  HomeCategoryView(),
                ],
              ),
            ),
        ),
    );
  }
}
