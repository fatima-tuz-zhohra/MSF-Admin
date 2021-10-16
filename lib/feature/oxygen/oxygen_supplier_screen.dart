
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/oxygen_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/feature/oxygen/add_oxygenSupplier_screen.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class OxygenSupplierScreen extends StatefulWidget {
  const OxygenSupplierScreen({Key? key}) : super(key: key);

  static const ROUTE = "/oxygenSuppliers";

  @override
  _OxygenSupplierScreenState createState() => _OxygenSupplierScreenState();
}

class _OxygenSupplierScreenState extends State<OxygenSupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddOxygenSupplierScreen.ROUTE);
        },
        label: Text('Add New Oxygen Supplier'),
      ),
      appBar: TopBar(title: 'Oxygen Supplier List', canGoBack: true,),
      
      body: MsfAdminBasePageLayout(
        child: StreamBuilder<List<OxygenItem>>(
          stream: OxygenService().getOxygen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;
              return OxygenSupplerListContent(oxygenSuppliers: data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class OxygenSupplerListContent extends StatefulWidget {
  const OxygenSupplerListContent({Key? key, required this.oxygenSuppliers}) : super(key: key);
  final List<OxygenItem> oxygenSuppliers;

  @override
  _OxygenSupplerListContentState createState() => _OxygenSupplerListContentState();
}

class _OxygenSupplerListContentState extends State<OxygenSupplerListContent> {

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
                  widget.oxygenSuppliers.length,
                      (index) => oxygenSuppliersDataRow(widget.oxygenSuppliers[index], context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  DataRow oxygenSuppliersDataRow(OxygenItem oxygenSuppliersInfo, BuildContext context) {
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
                text: oxygenSuppliersInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  oxygenSuppliersInfo.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(oxygenSuppliersInfo.address!)),
        DataCell(Text(oxygenSuppliersInfo.phoneNo!)),
        DataCell(Text('${oxygenSuppliersInfo.latitude!}')),
        DataCell(Text('${oxygenSuppliersInfo.longitude!}')),
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
                                      "Are you sure want to delete '${oxygenSuppliersInfo.name}'?"),
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
