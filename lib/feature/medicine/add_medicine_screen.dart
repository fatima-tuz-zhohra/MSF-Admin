import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/constants.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/add_input_field.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/rounded_button.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class AddMedicineScreen extends StatelessWidget {
  static const ROUTE = "/add-new-medicine";

  AddMedicineScreen({Key? key}) : super(key: key);

  final medicineNameController = TextEditingController();
  final medicineGenericController = TextEditingController();
  final medicineCompanyNameController = TextEditingController();
  final medicinePriceController = TextEditingController();
  final medicineDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Add New Medicine Item',
      ),
      body: MsfAdminBasePageLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: FractionallySizedBox(
                widthFactor: .7,
                child: _buildBody(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            AddInputField(
              hintText: 'Medicine Name',
              controller: medicineNameController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter medicine name';
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            AddInputField(
              hintText: 'Medicine Generic',
              controller: medicineGenericController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter medicine generic';
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            AddInputField(
              hintText: 'Company Name',
              controller: medicineCompanyNameController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter medicine company name';
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            AddInputField(
              hintText: 'Medicine Price',
              controller: medicinePriceController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter medicine price';

                final isValid =
                    RegExp(AppConstants.priceValidation).hasMatch(value!);

                if (!isValid) return 'Please enter valid medicine price';
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            AddInputField(
              hintText: 'Medicine Description',
              controller: medicineDescriptionController,
              maxline: 5,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter medicine Description';
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: RoundedButton(
                text: 'Save new medicine',
                press: () async {
                  if (_formKey.currentState?.validate() == true) {
                    await _saveNewMedicine();
                    showSnackbar(
                      context,
                      Text('New Medicine Added Successfully'),
                    );
                    Navigator.pop(context);
                  } else {
                    showSnackbar(
                      context,
                      Text('Invalid Inputs'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveNewMedicine() async {
    final name = medicineNameController.text;
    final generic = medicineGenericController.text;
    final company = medicineCompanyNameController.text;
    final price = double.tryParse(medicinePriceController.text) ?? 0;
    final description = medicineDescriptionController.text;
    return MedicineService().addNew(name, generic, company, price, description);
  }
}
