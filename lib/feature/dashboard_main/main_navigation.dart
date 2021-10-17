import 'package:flutter/material.dart';
import 'package:flutter_project_template/feature/blood/blood_donor_screen.dart';
import 'package:flutter_project_template/feature/dashboard_main/dashboard_page.dart';
import 'package:flutter_project_template/feature/dashboard_main/profile_screen.dart';
import 'package:flutter_project_template/feature/doctor/doctor_screen.dart';
import 'package:flutter_project_template/feature/hospital/hospital_screen.dart';
import 'package:flutter_project_template/feature/medicine/medicine_screen.dart';
import 'package:flutter_project_template/feature/oxygen/oxygen_supplier_screen.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(title: 'Menu',canGoBack: false,),
          ProfileScreen(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Main Navigation'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, DashboardScreen.ROUTE);
                  },
                  child: const Text('Dashboard'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Category'),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left:24.0),
                   child: SizedBox(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           TextButton(
                             style: TextButton.styleFrom(
                               padding: const EdgeInsets.all(16.0),
                               textStyle: theme.textTheme.bodyText2,
                             ),
                             onPressed: () {
                               Navigator.pushNamed(context, MedicineScreen.ROUTE);
                             },
                             child: const Text('Medicines'),
                           ),
                           TextButton(
                             style: TextButton.styleFrom(
                               padding: const EdgeInsets.all(16.0),
                               textStyle: theme.textTheme.bodyText2,
                             ),
                             onPressed: () {
                               Navigator.pushNamed(context, HospitalScreen.ROUTE);
                             },
                             child: const Text('Hospitals'),
                           ),
                           TextButton(
                             style: TextButton.styleFrom(
                               padding: const EdgeInsets.all(16.0),
                               textStyle: theme.textTheme.bodyText2,
                             ),
                             onPressed: () {
                               Navigator.pushNamed(context, DoctorScreen.ROUTE);
                             },
                             child: const Text('Doctors'),
                           ),
                           TextButton(
                             style: TextButton.styleFrom(
                               padding: const EdgeInsets.all(16.0),
                               textStyle: theme.textTheme.bodyText2,
                             ),
                             onPressed: () {
                               Navigator.pushNamed(context, BloodDonorScreen.ROUTE);
                             },
                             child: const Text('Blood Donors'),
                           ),
                           TextButton(
                             style: TextButton.styleFrom(
                               padding: const EdgeInsets.all(16.0),
                               textStyle: theme.textTheme.bodyText2,
                             ),
                             onPressed: () {
                               Navigator.pushNamed(context, OxygenSupplierScreen.ROUTE);
                             },
                             child: const Text('Oxygen Suppliers'),
                           ),
                         ],
                       )),
                 ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Chatting'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Send Notification'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Reviews'),

                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  onPressed: () {},
                  child: const Text('Settings'),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
