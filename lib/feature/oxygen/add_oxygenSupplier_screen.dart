import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/data/services/database.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/add_input_field.dart';
import 'package:flutter_project_template/widget/msf_admin_base_page_layout.dart';
import 'package:flutter_project_template/widget/rounded_button.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class AddOxygenSupplierScreen extends StatelessWidget {
  static const ROUTE = "/add-new-oxygen-supplier";
  AddOxygenSupplierScreen({Key? key}) : super(key: key);

  final supplierNameController = TextEditingController();
  final supplierAddressController = TextEditingController();
  final phoneNoController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Add New Oxygen Supplier',
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
      margin: EdgeInsets.all(16),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              AddInputField(
                hintText: 'Supplier Name',
                controller: supplierNameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter hospital name';
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddInputField(
                hintText: 'Supplier Address',
                controller: supplierAddressController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter hospital address';
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddInputField(
                hintText: 'Supplier Phone Number',
                controller: phoneNoController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter hospital phone number';
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddInputField(
                hintText: 'Latitude',
                controller: latitudeController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter hospital latitude';
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddInputField(
                hintText: 'Longitude',
                controller: longitudeController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter hospital longitude';
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: RoundedButton(
                  text: 'Save new supplier',
                  press: () async {
                    if (_formKey.currentState?.validate() == true) {
                      await _saveNewHospital();
                      showSnackbar(
                        context,
                        Text('New Supplier Added Successfully'),
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
      ),
    );
  }

  Future<void> _saveNewHospital() async {
    final name = supplierNameController.text;
    final address = supplierAddressController.text;
    final phoneNo = phoneNoController.text;

    final latitude = double.tryParse(latitudeController.text) ?? 0;
    final longitude = double.tryParse(longitudeController.text) ?? 0;

    return OxygenService().addNew( name, address, phoneNo, latitude, longitude );
  }

}
