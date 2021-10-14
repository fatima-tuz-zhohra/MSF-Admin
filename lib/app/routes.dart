
import 'package:flutter_project_template/feature/blood/blood_bank_screen.dart';
import 'package:flutter_project_template/feature/blood/blood_donor_screen.dart';
import 'package:flutter_project_template/feature/dashboard_main/dashboard_page.dart';
import 'package:flutter_project_template/feature/doctor/doctor_screen.dart';
import 'package:flutter_project_template/feature/hospital/hospital_screen.dart';
import 'package:flutter_project_template/feature/login/login_page.dart';
import 'package:flutter_project_template/feature/medicine/add_medicine_screen.dart';
import 'package:flutter_project_template/feature/medicine/medicine_screen.dart';
import 'package:flutter_project_template/feature/oxygen/oxygen_supplier_screen.dart';
import 'package:flutter_project_template/feature/signup/signup_page.dart';
import 'package:flutter_project_template/feature/splash/splash_page.dart';
import 'package:flutter_project_template/feature/users/user_list_screen.dart';

final initialRoute = SplashPage.ROUTE;
final appRoutes = {
  SplashPage.ROUTE: (context) => SplashPage(),
  LoginPage.ROUTE: (context) => LoginPage(),
  SignupPage.ROUTE: (context) => SignupPage(),
  HomePage.ROUTE: (context) => HomePage(),
  MedicineScreen.ROUTE: (context) => MedicineScreen(),
  BloodBankScreen.ROUTE: (context) => BloodBankScreen(),
  BloodDonorScreen.ROUTE: (context) => BloodDonorScreen(),
  DoctorScreen.ROUTE: (context) => DoctorScreen(),
  HospitalScreen.ROUTE: (context) => HospitalScreen(),
  OxygenSupplierScreen.ROUTE: (context) => OxygenSupplierScreen(),
  UserListScreen.ROUTE: (context) => UserListScreen(),
  AddMedicineScreen.ROUTE: (context) => AddMedicineScreen(),
};
