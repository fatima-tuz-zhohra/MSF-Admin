import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/hospital_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/widget/List_item.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  static const ROUTE = "/hospitals";

  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Hospital List'),

      body: MsfAdminBasePageLayout(
        child: StreamBuilder<List<HospitalItem>>(
            stream: HospitalService().getHospital(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final hospitals = snapshot.requireData;
                return HospitalListContent(hospitals: hospitals);
              } else {
                return Container();
              }
            }),
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
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      hospitals = widget.hospitals;
    }
    return ListView.builder(
      itemCount: hospitals.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          child: ListTile(
            title: Text('${hospitals[index].name}'),
            subtitle: Text('${hospitals[index].address}'),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.edit_outlined),
                  color: theme.colorScheme.secondary,
                  onPressed: () {
                  },
                ),
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.delete_forever),
                  color: theme.colorScheme.error,
                  onPressed: () {
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
