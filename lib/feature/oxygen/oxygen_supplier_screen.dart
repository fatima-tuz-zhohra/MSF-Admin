import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

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
      body: MsfAdminBasePageLayout(
        child: CustomScrollView(

        ),
      ),
    );
  }
}
