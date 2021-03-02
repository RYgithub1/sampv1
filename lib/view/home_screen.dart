import 'package:flutter/material.dart';
import 'postit_screen.dart';




class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('goooooo'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => PostitScreen(),
            )),
          ),
        ],
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}