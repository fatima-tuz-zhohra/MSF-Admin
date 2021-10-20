import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/feature/blood/blood_donor_screen.dart';
import 'package:flutter_project_template/feature/dashboard_main/dashboard_page.dart';
import 'package:flutter_project_template/feature/dashboard_main/profile_screen.dart';
import 'package:flutter_project_template/feature/doctor/doctor_screen.dart';
import 'package:flutter_project_template/feature/hospital/hospital_screen.dart';
import 'package:flutter_project_template/feature/login/login_page.dart';
import 'package:flutter_project_template/feature/medicine/medicine_screen.dart';
import 'package:flutter_project_template/feature/oxygen/oxygen_supplier_screen.dart';
import 'package:flutter_project_template/widget/top_bar.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: SingleChildScrollView(
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
                    child:  Row(
                      children: [
                        Icon(Icons.dashboard),
                        SizedBox(width: 8,),
                        Text('Dashboard'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () {},
                    child:  Row(
                      children: [
                        Icon(Icons.category),
                        SizedBox(width: 8,),
                        Text('Category'),
                      ],
                    ),
                  ),
                  Padding(
                     padding:  EdgeInsets.only(left:52.0),
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
                               child:  Text('Medicines'),
                             ),
                             TextButton(
                               style: TextButton.styleFrom(
                                 padding: const EdgeInsets.all(16.0),
                                 textStyle: theme.textTheme.bodyText2,
                               ),
                               onPressed: () {
                                 Navigator.pushNamed(context, HospitalScreen.ROUTE);
                               },
                               child:  Text('Hospitals'),
                             ),
                             TextButton(
                               style: TextButton.styleFrom(
                                 padding: const EdgeInsets.all(16.0),
                                 textStyle: theme.textTheme.bodyText2,
                               ),
                               onPressed: () {
                                 Navigator.pushNamed(context, DoctorScreen.ROUTE);
                               },
                               child:  Text('Doctors'),
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
                                 padding:  EdgeInsets.all(16.0),
                                 textStyle: theme.textTheme.bodyText2,
                               ),
                               onPressed: () {
                                 Navigator.pushNamed(context, OxygenSupplierScreen.ROUTE);
                               },
                               child:  Text('Oxygen Suppliers'),
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
                    child:  Row(
                      children: [
                        Icon(Icons.chat),
                        SizedBox(width: 8,),
                        Text('Chatting'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () {},
                    child:  Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 8,),
                        Text('Send Notification'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () {},
                    child:  Row(
                      children: [
                        Icon(Icons.reviews),
                        SizedBox(width: 8,),
                        Text('Reviews'),
                      ],
                    ),

                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () {},
                    child:  Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8,),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () {},
                    child:  Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 8,),
                        Text('About Us'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: theme.textTheme.subtitle2,
                    ),
                    onPressed: () async{
                      await  FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.ROUTE, (route) => false);
                    },
                    child:  Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8,),
                        Text('LogOut'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
