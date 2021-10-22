import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/user.dart';
import 'package:flutter_project_template/util/color_tag.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class UserListScreen extends StatelessWidget {
  static const ROUTE = "/user-list";

  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<User> users =
        ModalRoute.of(context)!.settings.arguments as List<User>;
    return Scaffold(
      appBar: TopBar(title: 'User List',),
      body: MsfAdminBasePageLayout(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                //scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: 16,
                    columns: [
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Role'),
                      ),
                      DataColumn(
                        label: Text('E-mail'),
                      ),
                      DataColumn(
                        label: Text('Phone No'),
                      ),
                      DataColumn(
                        label: Text('Registration Date'),
                      ),
                      DataColumn(
                        label: Text('Operation'),
                      ),
                    ],
                    rows: List.generate(
                      users.length,
                      (index) => usersDataRow(users[index], context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow usersDataRow(User userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              TextAvatar(
                size: 35,
                backgroundColor: Theme.of(context).colorScheme.background,
                textColor: Theme.of(context).colorScheme.background,
                fontSize: 14,
                upperCase: true,
                numberLetters: 1,
                shape: Shape.Rectangle,
                text: userInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  userInfo.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.role).withOpacity(.2),
              border: Border.all(color: getRoleColor(userInfo.role)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(userInfo.role!),
          ),
        ),
        DataCell(Text(userInfo.email!)),
        DataCell(Text(userInfo.phoneNo!)),
        DataCell(Text(userInfo.date ?? '')),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text('View',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onPressed: () {},
              ),
              SizedBox(
                width: 6,
              ),
              TextButton(
                child: Text("Delete",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.warning_outlined,
                                      size: 36,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  SizedBox(height: 20),
                                  Text("Confirm Deletion"),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 70,
                              child: Column(
                                children: [
                                  Text(
                                      "Are you sure want to delete '${userInfo.name}'?"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Cancel")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.delete,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .colorScheme
                                                  .error),
                                          onPressed: () {},
                                          label: Text("Delete"))
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
