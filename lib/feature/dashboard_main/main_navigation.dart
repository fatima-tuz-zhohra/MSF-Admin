import 'package:flutter/material.dart';
import 'package:flutter_project_template/feature/dashboard_main/profile_screen.dart';
import 'package:flutter_project_template/widget/expanded_button_list.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(title: 'Menu',canGoBack: false,),
          ProfileScreen(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Main Navigation'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Dashboard'),
                ),
                 SizedBox(
                   height: 100,
                     child: ExpandedButtonList()),

                /*TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Category'),
                ),*/
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Chat'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Send Notification'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Reviews'),

                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Settings'),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
