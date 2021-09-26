import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';

class BloodDonorScreen extends StatefulWidget {
  const BloodDonorScreen({Key? key}) : super(key: key);

  static const ROUTE = "/bloodDonors";

  @override
  _BloodDonorScreenState createState() => _BloodDonorScreenState();
}

class _BloodDonorScreenState extends State<BloodDonorScreen> {
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
