import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _urlLaunch = 'https://flutter.dev/docs';

    return Scaffold(
      appBar: AppBar(
        title: Text('LAUNCH'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => null,
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Flutter HP'),
                // onPressed: () => {await launch('https://flutter.dev/docs')},
                onPressed: () async{
                  if (await canLaunch(_urlLaunch)) {
                    launch(_urlLaunch);
                  } else {
                    print('comm100: Could not launch: $_urlLaunch');
                  }
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Flutter TEL'),
                onPressed: () => {launch('tel:+1 555 010 2345')},
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Flutter SMS'),
                onPressed: () => {launch('sms:+1 555 010 2345')},
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Flutter MAIL'),
                onPressed: () => {launch('mailto:flutterexample@gmail.com')},
              ),
            ]
          ),
        ),
      ),
    );
  }
}