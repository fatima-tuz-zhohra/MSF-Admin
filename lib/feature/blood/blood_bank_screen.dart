import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

class BloodBankScreen extends StatefulWidget {
  const BloodBankScreen({Key? key}) : super(key: key);

  static const ROUTE = "/bloodBanks";

  @override
  _BloodBankScreenState createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
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
