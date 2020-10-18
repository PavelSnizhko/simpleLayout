import 'package:first_step_in_layout/main.dart';
import 'package:flutter/material.dart';

class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          child: new Text("Drawer"),
          decoration: new BoxDecoration(color: Colors.blue),
        ),
        new ListTile(
          title: new Text("Main"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt, new MaterialPageRoute(builder: (ctxt) => PersonWidget()));
          },
        ),
        new ListTile(
          title: new Text("Second Page"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(ctxt,
                new MaterialPageRoute(builder: (ctxt) => new SecondPage()));
          },
        ),
      ],
    ));
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new DrawerOnly(), // New Line
      appBar: new AppBar(
        title: new Text("Second Page"),
      ),
      body: Center(
        child: Text("Okey I'll be the second page!"),
      ),
    );
  }
}
