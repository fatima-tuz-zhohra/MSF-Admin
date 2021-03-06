import 'package:flutter_project_template/common/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchUrl(String url) async {
  final shouldProceed = await canLaunch(url);
  if (shouldProceed) await launch(AppConstants.terms_url);
  return shouldProceed;
}

String formatToLocalDate(DateTime dateTime) {
  final format = "MMM/dd/yyyy hh:mm:ss a";
  return formatDateTime(format, dateTime);
}

String formatDateTime(String format, DateTime dateTime) {
  final formatter = DateFormat(format);
  return formatter.format(dateTime);
}