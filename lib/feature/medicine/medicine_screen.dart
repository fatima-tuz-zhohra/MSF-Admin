import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/List_item.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

import 'add_medicine_screen.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  static const ROUTE = "/medicines";

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
        label: Text('Add New'),
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
    return ListView.builder(
      itemCount: widget.medicines.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.background,
                child: Image.asset('assets/icons/medicine_icon.png'),
              ),
              title: Text('${widget.medicines[index].name}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text('৳ ${widget.medicines[index].price}')),
                  SizedBox(height: 2),
                  Chip(label: Text('${widget.medicines[index].generic}'))
                ],
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.edit_outlined),
                    color: theme.colorScheme.secondary,
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.delete_forever),
                    color: theme.colorScheme.error,
                    onPressed: () async {
                      await MedicineService().delete(widget.medicines[index]);
                      showSnackbar(context, Text('Deleted successfully'));
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
