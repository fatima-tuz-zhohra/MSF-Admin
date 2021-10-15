import 'package:flutter/material.dart';

class ExpandedMenuList extends StatelessWidget {
  const ExpandedMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: ListView.builder(
          itemBuilder: (BuildContext, int index) {
            return ExpandableListView(title: "Title $index");
          },
          itemCount: 5,
      ),
    );
  }
}

class ExpandableListView extends StatefulWidget {
  final String title;

  const ExpandableListView({Key? key, required this.title}) : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
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
                          color: Colors.white,
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
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      color: Colors.black),
                  child: ListTile(
                    title: Text(
                      "Cool $index",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.local_pizza,
                      color: Colors.white,
                    ),
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
        decoration:  BoxDecoration(
            border:  Border.all(width: 1.0, color: Colors.blue)),
      ),
    );
  }
}
