import 'package:flutter/material.dart';

class TopBar extends PreferredSize {
  TopBar(
      {Key? key,
      required this.title,
      this.canGoBack = true,
      this.actions = const []})
      : super(
          preferredSize: Size.fromHeight(58),
          child: _TopBarWidget(
            title: title,
            canGoBack: canGoBack,
            actions: actions,
          ),
        );

  final bool canGoBack;
  final String title;
  final List<Widget> actions;
}

class _TopBarWidget extends StatelessWidget {
  const _TopBarWidget({
    Key? key,
    required this.title,
    this.canGoBack = true,
    this.actions = const [],
  }) : super(key: key);

  final bool canGoBack;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      //backgroundColor: Colors.transparent,
      automaticallyImplyLeading: canGoBack,
      actions: this.actions,
    );
  }
}
