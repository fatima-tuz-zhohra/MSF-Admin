import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/widget/List_item.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

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
      appBar: AppBar(title: Text('Medicine List'),),

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
  List<MedicineItem> medicines = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(child: ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/icons/medicine_icon3.png'),
            ),
            title: Text('${medicines[index].name}'),
            subtitle: Text('${medicines[index].generic}'),
            trailing: Text(' ৳  ${medicines[index].price}'),
          ),
        );
      },
    ),
    );
  }

}
