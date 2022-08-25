//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/screen/viewprofile.dart';
import '/screen/viewrecord.dart';

var id;
var did;

class pTabs extends StatefulWidget {
  //const pTabs({Key? key}) : super(key: key);

  pTabs(d, ) {
    id = d;
    
  }
  @override
  State<pTabs> createState() => _pTabsState();
}

class _pTabsState extends State<pTabs> {
 
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("profile"),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.perm_identity,
                ),
                text: 'profile',
              ),
              Tab(
                icon: Icon(Icons.assignment_outlined),
                text: 'record',
              ),
            ]),
          ),
          body: TabBarView(children: [viewprofile(id), viewRecord(id)]),
        ));
  }
}
