import 'package:flutter/material.dart';
import 'package:flutter_project_template/widget/add_input_field.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class AddMedicineScreen extends StatelessWidget {
  static const ROUTE = "/add-new-medicine";

   AddMedicineScreen({Key? key}) : super(key: key);

  final medicineNameController = TextEditingController();
  final medicineGenericController = TextEditingController();
  final medicineCompanyNameController = TextEditingController();
  final medicinePriceController = TextEditingController();
  final medicineDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Add New Medicine Item',),

      body: MsfAdminBasePageLayout(
        child: CustomScrollView(
          slivers: [
           SliverFillRemaining(
             hasScrollBody: false,
               child: _buildBody(context),
           ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return Form(
      child: Column(
        children: [
          SizedBox(height: 16,),
          AddInputField(hintText: 'Medicine Name', controller: medicineNameController),
          SizedBox(height: 12,),

          AddInputField(hintText: 'Medicine Generic', controller: medicineGenericController),
          SizedBox(height: 12,),

          AddInputField(hintText: 'Company Name', controller: medicineCompanyNameController),
          SizedBox(height: 12,),

          AddInputField(hintText: 'Medicine Price', controller: medicinePriceController),
          SizedBox(height: 12,),

          AddInputField(hintText: 'Medicine Description', controller: medicineDescriptionController),
          SizedBox(height: 12,),
        ],
      ), );
  }

}
