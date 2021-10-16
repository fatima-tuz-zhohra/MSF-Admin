import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/util/color_tag.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

import 'add_medicine_screen.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  static const ROUTE = "/medicines-list";

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddMedicineScreen.ROUTE);
        },
        label: Text('Add New Medicine'),
      ),
      appBar: TopBar(title: 'Medicine List'),
      body: MsfAdminBasePageLayout(
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: MedicineService().getMedicines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;
              final List<MedicineItem> medicines = [];

              data.docs.forEach((element) {
                final dbItem = element.data()! as Map<String, dynamic>;
                final medicine = MedicineItem(
                    element.id,
                    dbItem['name'],
                    dbItem['generic'],
                    dbItem['companyName'],
                    double.parse("${dbItem['price']}"),
                    dbItem['description']);
                medicines.add(medicine);
              });
              return MedicineListContent(medicines: medicines);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class MedicineListContent extends StatefulWidget {
  const MedicineListContent({Key? key, required this.medicines})
      : super(key: key);
  final List<MedicineItem> medicines;

  @override
  _MedicineListContentState createState() => _MedicineListContentState();
}

class _MedicineListContentState extends State<MedicineListContent> {
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
                    label: Text('Medicine Name'),
                  ),
                  DataColumn(
                    label: Text('Generic'),
                  ),
                  DataColumn(
                    label: Text('Company Name'),
                  ),
                  DataColumn(
                    label: Text('price'),
                  ),
                  DataColumn(
                    label: Text('Description'),
                  ),
                  DataColumn(
                    label: Text('Operation'),
                  ),
                ],
                rows: List.generate(
                  widget.medicines.length,
                  (index) => medicinesDataRow(widget.medicines[index], context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow medicinesDataRow(MedicineItem medicineInfo, BuildContext context) {
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
                text: medicineInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  medicineInfo.name!,
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
              color: getRoleColor(medicineInfo.generic).withOpacity(.2),
              border: Border.all(color: getRoleColor(medicineInfo.generic)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(medicineInfo.generic!),
          ),
        ),
        DataCell(Text(medicineInfo.companyName!)),
        DataCell(Text('${medicineInfo.price!}')),
        DataCell(Text(medicineInfo.description!)),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text('Edit',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddMedicineScreen.ROUTE,
                    arguments: medicineInfo,
                  );
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
                                      "Are you sure want to delete '${medicineInfo.name}'?"),
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
                                            await MedicineService()
                                                .delete(medicineInfo);
                                            showSnackbar(
                                              context,
                                              Text('Deleted Successfully'),
                                            );
                                            Navigator.pop(context);
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
