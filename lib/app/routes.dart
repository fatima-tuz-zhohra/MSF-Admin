import 'package:flutter_project_template/category/blood/blood_bank_screen.dart';
import 'package:flutter_project_template/category/blood/blood_donor_screen.dart';
import 'package:flutter_project_template/category/dortor/doctor_screen.dart';
import 'package:flutter_project_template/category/hospital/hospital_screen.dart';
import 'package:flutter_project_template/category/medicine/medicine_screen.dart';
import 'package:flutter_project_template/category/oxygen/osygen_supplier_screen.dart';
import 'package:flutter_project_template/feature/home/home_page.dart';
import 'package:flutter_project_template/feature/login/login_page.dart';
import 'package:flutter_project_template/feature/signup/signup_page.dart';
import 'package:flutter_project_template/feature/splash/splash_page.dart';

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
};
