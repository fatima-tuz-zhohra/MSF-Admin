import 'package:flutter/material.dart';
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
    return MsfAdminBasePageLayout(child: Scaffold());
  }
}
