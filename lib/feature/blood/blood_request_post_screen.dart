import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/blood_request_post.dart';
import 'package:flutter_project_template/common/data/services/blood_requests_service.dart';
import 'package:flutter_project_template/util/color_tag.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class BloodRequestListScreen extends StatelessWidget {
  static const ROUTE = "/blood-request-post-list";

  const BloodRequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BloodRequest> bloodRequests =
        ModalRoute.of(context)!.settings.arguments as List<BloodRequest>;
    return Scaffold(
      appBar: TopBar(
        title: 'Blood Requests',
      ),
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
                        label: Text('Blood Group'),
                      ),
                      DataColumn(
                        label: Text('Phone No'),
                      ),
                      DataColumn(
                        label: Text('Description'),
                      ),
                      DataColumn(
                        label: Text('Posted Date'),
                      ),
                      DataColumn(
                        label: Text('Status'),
                      ),
                      DataColumn(
                        label: Text('Operation'),
                      ),
                    ],
                    rows: List.generate(
                      bloodRequests.length,
                      (index) =>
                          bloodRequestsDataRow(bloodRequests[index], context),
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

  DataRow bloodRequestsDataRow(
      BloodRequest bloodRequestInfo, BuildContext context) {
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
                text: bloodRequestInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  bloodRequestInfo.name!,
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
              color: getRoleColor(bloodRequestInfo.bloodGroup).withOpacity(.2),
              border:
                  Border.all(color: getRoleColor(bloodRequestInfo.bloodGroup)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(bloodRequestInfo.bloodGroup!),
          ),
        ),
        DataCell(Text(bloodRequestInfo.phoneNo!)),
        DataCell(Text(
          bloodRequestInfo.description,
          maxLines: 5,
        )),
        DataCell(Text(bloodRequestInfo.postedDate ?? '')),
        DataCell(Text(bloodRequestInfo.status)),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text('Approve',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onPressed: () async {
                  await BloodRequestListService().approve(bloodRequestInfo);
                  showSnackbar(context, Text('Approved'));
                },
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
                                      "Are you sure want to delete '${bloodRequestInfo.name}'?"),
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
                                          onPressed: () async {
                                            await BloodRequestListService()
                                                .delete(bloodRequestInfo);
                                            showSnackbar(
                                                context, Text('Deleted'));
                                          },
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
