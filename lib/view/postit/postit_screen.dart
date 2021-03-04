import 'package:flutter/material.dart';
import 'package:sampv1/view/launch/launch_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'postit_edit_screen.dart';




class PostitScreen extends StatefulWidget {
  @override
  _PostitScreenState createState() => _PostitScreenState();
}




class _PostitScreenState extends State<PostitScreen> {
  var _memoList = List<String>();
  var _currentIndex = -1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    this.loadMemoList();
  }
  void loadMemoList() {
    SharedPreferences.getInstance().then((prefsValuable) {
      const key = 'memoListKey';
      // var key = ObjectKey(_memoList[_currentIndex]);
      // if (prefsValuable.containsKey('$key')) {
      if (prefsValuable.containsKey(key)) {
        _memoList = prefsValuable.getStringList(key);
      }
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST IT'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => LaunchScreen(),
            )),
          ),
        ],
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Postit',
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _memoList.add('');
            _currentIndex = _memoList.length -1;
            storeMemoList();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PostitEditScreen(
                _memoList[_currentIndex],
                _onChanged,
              ),
            ));
          });
        },
      ),
    );
  }



  Widget _buildList() {
    final _itemCount = _memoList.length == 0
                          ? 0
                          : _memoList.length * 2 -1;   /// Divider挟むため
    return ListView.builder(
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider(height: 1, thickness: 3);
        final _number = (index/2).floor();  /// [.floor(): Returns the greatest integer]
        final _memo = _memoList[_number];

        return Dismissible(
          background: Container(
            color: Colors.green,
            child: Icon(Icons.check),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerRight,
          ),

          key: Key(_memo),

          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // if (direction == DismissDirection.startToEnd) {
            //   final snackBar = SnackBar(content: Text('Share'));
            //   Scaffold.of(context).showSnackBar(snackBar);
            //   /// TODO: SHARE
            // }
            // if (direction == DismissDirection.endToStart) {
            //   final snackBar = SnackBar(content: Text('Delete'));
            //   Scaffold.of(context).showSnackBar(snackBar);
            //   setState(() {
            //     _memoList.removeAt(_number);
            //     storeMemoList();
            //   });
            // }
            setState(() {
                _memoList.removeAt(_number);
                storeMemoList();
              });
          },

          child: ListTile(
            title: Text(
              _memo,
              style: TextStyle(fontSize: 20.0),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => PostitEditScreen(
                _memoList[_currentIndex],
                _onChanged,
              ),
            )),
          )
        );
      },
    );
  }



  void _onChanged(String text) {
    setState(() {
      _memoList[_currentIndex] = text;
      storeMemoList();
    });
  }
  void storeMemoList() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    const key = 'memoListKey';
    // var key = ObjectKey(_memoList[_currentIndex]);
    final _success = await _sharedPreferences.setStringList(key, _memoList);
    if (!_success) {
      debugPrint('Failed to store value');
    }
  }


}