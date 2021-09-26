import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/dashboard_list_view.dart';

class DashboardPanelScreen extends StatelessWidget {
  const DashboardPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
         children: [
           DashboardListView(
             title: '150',
             subTitle: 'Medicine List',
             image: 'assets/icon/medicine_icon.png',
             onTap: (){},
           ),
           DashboardListView(
             title: '150',
             subTitle: 'Hospital Request',
             image: 'assets/icon/hospital_icon.png',
             onTap: (){},
           ),
         ],
      ),
    );
  }
}
