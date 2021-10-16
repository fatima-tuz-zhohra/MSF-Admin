import 'package:flutter/material.dart';
import 'package:flutter_project_template/common/constants.dart';
import 'package:flutter_project_template/common/data/model/items/medicine_item.dart';
import 'package:flutter_project_template/common/data/services/medicine_service.dart';
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

  MedicineItem? _medicineItem;

  @override
  Widget build(BuildContext context) {
    _medicineItem = ModalRoute.of(context)?.settings.arguments as MedicineItem?;

    if (_medicineItem != null) _prefillInputs(_medicineItem!);

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
                  text: _medicineItem != null
                      ? 'Edit Medicine'
                      : 'Save new medicine',
                  press: () async {
                    if (_formKey.currentState?.validate() == true) {
                      await _saveNewMedicine();
                      showSnackbar(
                        context,
                        Text(_medicineItem != null
                            ? 'Medicine Updated Successfully'
                            : 'Medicine Added Successfully'),
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

  Future<void> _saveNewMedicine() async {
    final name = medicineNameController.text;
    final generic = medicineGenericController.text;
    final company = medicineCompanyNameController.text;
    final price = double.tryParse(medicinePriceController.text) ?? 0;
    final description = medicineDescriptionController.text;
    if (_medicineItem != null) {
      //editing
      return MedicineService().update(
        _medicineItem!.id!,
        name,
        generic,
        company,
        price,
        description,
      );
    } else {
      //new adding
      return MedicineService()
          .addNew(name, generic, company, price, description);
    }
  }

  void _prefillInputs(MedicineItem medicineItem) {
    medicineNameController.text = medicineItem.name ?? '';
    medicineGenericController.text = medicineItem.generic ?? '';
    medicineCompanyNameController.text = medicineItem.companyName ?? '';
    medicinePriceController.text = medicineItem.price?.toString() ?? '0';
    medicineDescriptionController.text = medicineItem.description ?? '';
  }
}
