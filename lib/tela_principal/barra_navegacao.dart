import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class navegacao extends StatelessWidget {
  const navegacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blue[50],
          child: barraContainer(),
        ),
      ),
    );
  }
}

class barraContainer extends StatefulWidget {
  const barraContainer({Key? key}) : super(key: key);

  @override
  State<barraContainer> createState() => _barraContainerState();
}

class _barraContainerState extends State<barraContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child: Text('teste'),
                ),
                Container(
                  child: Text('ede'),
                ),
                Container(
                  child: Text('dedede'),
                ),
              ],
            )),
        Container(
          child: Text('data'),
        )
      ]),
    );
  }
}



// expande por fora
/*
  @override
  Widget build(BuildContext context) {
    final isCollapsed = true;

    return Container(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.1 : null,
        child: Drawer(child: Container(color: Colors.amberAccent[50])));
  }

 */