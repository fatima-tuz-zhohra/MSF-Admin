import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

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
      body: MsfAdminBasePageLayout(
        child: CustomScrollView(

        ),
      ),
    );
  }
}
