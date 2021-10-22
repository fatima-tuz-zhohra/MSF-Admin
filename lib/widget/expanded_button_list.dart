import 'package:flutter/material.dart';

class ExpandedButtonList extends StatelessWidget {
  const ExpandedButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        width: 500,
        child: ListView.builder(
          itemBuilder: (BuildContext, int index) {
            return ButtonList(title: "Title $index");
          },
          itemCount: 1,
        ),
      );
    }
  }

class ButtonList extends StatefulWidget {
  final String title;

  const ButtonList({Key? key, required this.title}) : super(key: key);

  @override
  _ButtonListState createState() => _ButtonListState();
  }

class _ButtonListState extends State<ButtonList> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: [
          Container(
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                IconButton(
                    icon:  Container(
                      height: 50.0,
                      width: 50.0,
                      child:  Center(
                        child:  Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 30.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
              ],
            ),
          ),

          ExpandableContainer(
            expanded: expandFlag,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: new EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon:  Container(
                            height: 50.0,
                            width: 50.0,
                            child:  Center(
                              child:  Icon(
                                expandFlag
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 30.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              expandFlag = !expandFlag;
                            });
                          }),
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return  AnimatedContainer(
      duration:  Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child:  Container(
        child: child,
      ),
    );
  }
}
