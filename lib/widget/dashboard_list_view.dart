import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardListView extends StatelessWidget {
  DashboardListView({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  String title;
  String subTitle;
  String image;
  Function() onTap;

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
          //padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              Positioned(top: 20, right: 12, child: Image.asset(image),
              height: 60,
              width: 60,),
              Container(
              padding: EdgeInsets.all(8),
                width: 240,
                color: Colors.lightBlue.withOpacity(0.8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: theme.textTheme.headline4
                          ?.copyWith(fontWeight: FontWeight.bold,color: Colors.white)
                  ),
                  SizedBox(height: 10),
                  Text(subTitle, style: theme.textTheme.bodyText2?.copyWith(color: Colors.white)),
                ]),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 240,
                  height: 24,
                  padding: EdgeInsets.all(4),
                  color: Colors.blue,
                  child: Text('More Info', textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 10),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}