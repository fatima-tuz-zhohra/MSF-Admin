import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

import 'dashbord_panel_screen.dart';
import 'dashboard_category_view.dart';
import 'main_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const ROUTE = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: MainNavigation()),
      body: MsfAdminBasePageLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  TopBar(title: 'Welcome'),
                  SizedBox(height: 16),
                  DashboardPanelScreen(),
                  SizedBox(height: 16),
                  HomeCategoryView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
