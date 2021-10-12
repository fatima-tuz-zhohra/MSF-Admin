import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/user.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

class UserListScreen extends StatelessWidget {
  static const ROUTE = "/user-list";

  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<User> users = ModalRoute.of(context)!.settings.arguments as List<User>;
    return Scaffold(
      body: MsfAdminBasePageLayout(child:
          Text('Count is ${users.length}')
      ),
    );
  }
}
