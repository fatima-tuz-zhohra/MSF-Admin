import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/blood_request_post.dart';
import 'package:flutter_project_template/common/data/model/user.dart';
import 'package:flutter_project_template/common/data/services/blood_requests_service.dart';
import 'package:flutter_project_template/common/data/services/users_service.dart';
import 'package:flutter_project_template/feature/blood/blood_request_post_screen.dart';
import 'package:flutter_project_template/feature/users/user_list_screen.dart';
import 'package:flutter_project_template/widget/dashboard_list_view.dart';
import 'package:flutter_project_template/util/ui_utils.dart';

class DashboardPanelScreen extends StatelessWidget {
  const DashboardPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          _createUserRegistrationCard(context),
          _createBloodRequestCard(context),
          DashboardListView(
            title: '000',
            subTitle: 'Doctor Request',
            image: 'assets/icons/blood-donor_icon.png',
            onTap: () {},
            color: theme.isDarkMode()
                ? Colors.green.shade200
                : Colors.green.shade300,
            color2: theme.isDarkMode()
                ? Colors.green.shade300
                : Colors.green.shade500,
          ),
        ],
      ),
    );
  }

  Widget _createBloodRequestCard(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<List<BloodRequest>>(
        stream: BloodRequestListService().getBloodPostList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.requireData;
            return DashboardListView(
              title: '${data.length}',
              subTitle: 'Blood Requests',
              image: 'assets/icons/blood_icon.png',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  BloodRequestListScreen.ROUTE,
                  arguments: data,
                );
              },
              color: theme.isDarkMode()
                  ? Colors.orange.shade200
                  : Colors.orange.shade300,
              color2: theme.isDarkMode()
                  ? Colors.orange.shade300
                  : Colors.orange.shade500,
            );
          } else {
            return Container();
          }
        });
  }

  Widget _createUserRegistrationCard(BuildContext context){
    final theme = Theme.of(context);
    return StreamBuilder<List<User>>(
        stream: UsersService().getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.requireData;
            return DashboardListView(
              title: '${data.length}',
              subTitle: 'User Registrations',
              image: 'assets/icons/user_icon.png',
              onTap: () {
                Navigator.pushNamed(context, UserListScreen.ROUTE,
                    arguments: data);
              },
              color: theme.isDarkMode()
                  ? Colors.blue.shade200
                  : Colors.blue.shade300,
              color2: theme.isDarkMode()
                  ? Colors.blue.shade300
                  : Colors.blue.shade500,
            );
          } else {
            return Container();
          }
        });
  }
}
