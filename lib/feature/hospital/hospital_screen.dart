import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/hospital_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

import 'add_hospital_screen.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  static const ROUTE = "/hospitals-list";

  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddHospitalScreen.ROUTE);
        },
        label: Text('Add New Hospital'),
      ),
      appBar: TopBar(title: 'Hospital List', canGoBack: true,),

      body: MsfAdminBasePageLayout(
        child: StreamBuilder<List<HospitalItem>>(
          stream: HospitalService().getHospital(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;
              return HospitalListContent(hospitals: data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class HospitalListContent extends StatefulWidget {
  const HospitalListContent({Key? key, required this.hospitals})
      : super(key: key);
  final List<HospitalItem> hospitals;

  @override
  _HospitalListContentState createState() => _HospitalListContentState();
}

class _HospitalListContentState extends State<HospitalListContent> {
  List<HospitalItem> hospitals = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                    label: Text('Address'),
                  ),
                  DataColumn(
                    label: Text('Type'),
                  ),
                  DataColumn(
                    label: Text('phoneNo'),
                  ),
                  DataColumn(
                    label: Text('latitude'),
                  ),
                  DataColumn(
                    label: Text('longitude'),
                  ),
                  DataColumn(
                    label: Text('Operation'),
                  ),
                ],
                rows: List.generate(
                  widget.hospitals.length,
                      (index) => hospitalsDataRow(widget.hospitals[index], context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  DataRow hospitalsDataRow(HospitalItem hospitalInfo, BuildContext context) {
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
                text: hospitalInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  hospitalInfo.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        /*DataCell(
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(hospitalInfo.generic).withOpacity(.2),
              border: Border.all(color: getRoleColor(hospitalInfo.generic)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
              ),
            ),
            child: Text(hospitalInfo.generic!),
          ),
        ),*/
        DataCell(Text(hospitalInfo.address!)),

        DataCell(Text(hospitalInfo.type!)),
        DataCell(Text(hospitalInfo.phoneNo!)),
        DataCell(Text('${hospitalInfo.latitude!}')),
        DataCell(Text('${hospitalInfo.longitude!}')),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text('Edit',
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
                                      "Are you sure want to delete '${hospitalInfo.name}'?"),
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
