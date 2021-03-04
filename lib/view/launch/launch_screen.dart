import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}




class _LaunchScreenState extends State<LaunchScreen> {
  bool _switchListTileToggled = false;   /// [Need rebuild -> Outside of build()]
  String _switchTitle = 'Bulgaria: ';  /// [Need rebuild -> Outside of build()]


  @override
  Widget build(BuildContext context) {
    const _urlLaunch = 'https://flutter.dev/docs';
    /// bool _switchListTileToggled = false;   /// [Need rebuild -> Outside of build()]
    /// String _switchTitle = 'Bulgaria: ';  /// [Need rebuild -> Outside of build()]

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

              /// [------ Launcher ------]
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
              SizedBox(height: 20),

              /// [------ SwitchListTile ------]
              SwitchListTile(
                value: _switchListTileToggled,
                onChanged: (bool value) {
                  setState(() {
                    _switchListTileToggled = value;
                    _switchTitle = 'Bulgaria -> $_switchListTileToggled';
                  });
                },
                title: Text('Yoghurt'),
                subtitle: Text(_switchTitle),
                secondary:  Icon(
                  Icons.thumb_up,
                  color: _switchListTileToggled
                      ? Colors.pink
                      : Colors.green,
                  size: 40.0,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.orange,
                activeTrackColor: Colors.red,
                inactiveThumbColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
              ),
            ]
          ),
        ),
      ),
    );
  }
}