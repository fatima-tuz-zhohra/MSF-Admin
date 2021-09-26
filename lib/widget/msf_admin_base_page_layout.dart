import 'package:flutter/material.dart';

class MsfAdminBasePageLayout extends StatelessWidget {
  const MsfAdminBasePageLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: this.child,
    );
  }
}
