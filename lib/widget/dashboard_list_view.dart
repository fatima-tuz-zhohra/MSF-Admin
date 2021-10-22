import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardListView extends StatelessWidget {
  DashboardListView({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
    required this.color,
    required this.color2,
  }) : super(key: key);

  String title;
  String subTitle;
  String image;
  Function() onTap;
  Color color;
  Color color2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 4,
        child: Container(
          width: 240,
          child: Stack(
            children: [
              Positioned(top: 10, right: 10, child: Image.asset(image),
              height: 60,
              width: 60,),
              Container(
              padding: EdgeInsets.all(8),
                width: 240,
                color: color.withOpacity(0.8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: theme.textTheme.headline4
                          ?.copyWith(fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 10),
                  Text(subTitle, style: theme.textTheme.bodyText2),
                ]),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 240,
                  height: 24,
                  padding: EdgeInsets.all(4),
                  color: color2,
                  child: Text('More Info', textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.background, fontSize: 10),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}