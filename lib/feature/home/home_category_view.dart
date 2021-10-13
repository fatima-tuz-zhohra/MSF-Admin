import 'package:flutter/material.dart';
import 'package:flutter_project_template/feature/blood/blood_bank_screen.dart';
import 'package:flutter_project_template/feature/doctor/doctor_screen.dart';
import 'package:flutter_project_template/feature/hospital/hospital_screen.dart';
import 'package:flutter_project_template/feature/medicine/medicine_screen.dart';
import 'package:flutter_project_template/feature/oxygen/oxygen_supplier_screen.dart';
import 'package:flutter_project_template/widget/grid_item.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          GridItem(
            title: 'Medicines',
            image: 'assets/icons/flutter_logo.png',
            onTap: () {
              Navigator.pushNamed(
                  context,
                  MedicineScreen.ROUTE
              );
            },
          ),
          GridItem(
            title: 'hospitals',
            image: 'assets/icons/flutter_logo.png',
            onTap: () {
              Navigator.pushNamed(
                  context,
                  HospitalScreen.ROUTE
              );
            },
          ),
          GridItem(
            title: 'doctors',
            image: 'assets/icons/flutter_logo.png',
            onTap: () {
              Navigator.pushNamed(
                  context,
                  DoctorScreen.ROUTE
              );
            },
          ),
          GridItem(
            title: 'Bloods',
            image: 'assets/icons/flutter_logo.png',
            onTap: () {
              Navigator.pushNamed(
                  context,
                  BloodBankScreen.ROUTE
              );
            },
          ),
          GridItem(
            title: 'Oxygen',
            image: 'assets/icons/flutter_logo.png',
            onTap: () {
              Navigator.pushNamed(
                  context,
                  OxygenSupplierScreen.ROUTE
              );
            },
          ),
        ],
      ),
    );
  }
}
