import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/model/items/oxygen_item.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/widget/List_item.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: TopBar(title: 'Oxygen Supplier List'),
      body: MsfAdminBasePageLayout(
        child:  StreamBuilder<QuerySnapshot<Object?>>(
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
              final List<OxygenItem> oxygens = [];

              data.docs.forEach((element) {
                final dbItem = element.data()! as Map<String, dynamic>;
                final oxygen = OxygenItem(
                    dbItem['name'],
                    dbItem['address'],
                    dbItem['PhoneNo'],
                    dbItem['latitude'],
                    dbItem['longitude']);
                oxygens.add(oxygen);
              });
              return OxygenListContent(oxygens: oxygens);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class OxygenListContent extends StatefulWidget {
  const OxygenListContent({Key? key, required this.oxygens}) : super(key: key);
  final List<OxygenItem> oxygens;

  @override
  _OxygenListContentState createState() => _OxygenListContentState();
}

class _OxygenListContentState extends State<OxygenListContent> {
  List<OxygenItem> oxygens = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      oxygens = widget.oxygens;
    }
    return ListView.builder(
          itemCount: oxygens.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(
              child: ListTile(
                title: Text('${oxygens[index].name}'),
                subtitle: Text('${oxygens[index].address}'),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.location_on),
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        navigateTo(oxygens[index].latitude,
                            oxygens[index].longitude);
                      },
                    ),
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.call),
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        launch(('tel://${oxygens[index].phoneNo}'));
                      },
                    )
                  ],
                ),
              ),
            );
          },
    );
  }

  void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("http://maps.google.com/maps?daddr=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
