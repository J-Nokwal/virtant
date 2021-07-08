import 'package:flutter/material.dart';
import 'package:virtant/screens/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          collapsedHeight: 150,
          expandedHeight: 250,
          pinned: true,
          backgroundColor: purpleDark,
          centerTitle: true,
          title: Text("Settings"),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.fromLTRB(40, 20, 20, 20),
            collapseMode: CollapseMode.pin,
            title: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.amber),
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Name Here")
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          Container(height: 190, color: Colors.pinkAccent),
          Container(height: 190, color: Colors.green),
          Container(height: 190, color: Colors.amber),
          Container(height: 240, color: Colors.green),
        ]))
      ]),
    );
  }
}
