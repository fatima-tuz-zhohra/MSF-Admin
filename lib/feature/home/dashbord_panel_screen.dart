import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/user.dart';
import 'package:flutter_project_template/common/data/services/users_service.dart';
import 'package:flutter_project_template/feature/users/user_list_screen.dart';
import 'package:flutter_project_template/widget/dashboard_list_view.dart';

class DashboardPanelScreen extends StatelessWidget {
  const DashboardPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          StreamBuilder<List<User>>(
              stream: UsersService().getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 44,
                    width: 44,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  return DashboardListView(
                    title: '${data.length}',
                    subTitle: 'User Registrations',
                    image: 'assets/icon/user_icon.png',
                    onTap: () {
                      Navigator.pushNamed(context, UserListScreen.ROUTE, arguments: data);
                    },
                    color: Colors.blue.shade300,
                    color2: Colors.blue.shade500,
                  );
                } else {
                  return Container();
                }
              }),
          DashboardListView(
            title: '150',
            subTitle: 'Donor Request',
            image: 'assets/icon/blood-donor_icon.png',
            onTap: () {},
            color: Colors.green.shade300,
            color2: Colors.green.shade500,
          ),
          DashboardListView(
            title: '150',
            subTitle: 'Blood Request Post',
            image: 'assets/icon/blood_icon.png',
            onTap: () {},
            color: Colors.orange.shade300,
            color2: Colors.orange.shade500,
          ),
        ],
      ),
    );
  }
}
