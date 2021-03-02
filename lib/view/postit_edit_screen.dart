import 'package:flutter/material.dart';




class PostitEditScreen extends StatelessWidget {
  String _current;
  final Function _onChanged;
  PostitEditScreen(this._current, this._onChanged);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('postit EDIT'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              return FocusScope.of(context).requestFocus(FocusNode());  
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: TextEditingController(text: _current),
          maxLines: 88,
          style: TextStyle(color: Colors.black),
          onChanged: (text) {
            _current = text;
            _onChanged(_current);
          },
        ),
      ),
    );
  }
}

