import 'package:flutter/material.dart';
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
    SharedPreferences.getInstance().then((prefs) {
      const key = 'memo-list';
      if (prefs.containsKey(key)) _memoList = prefs.getStringList(key);
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
                          : _memoList.length * 2 -1;
    return ListView.builder(
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider(height: 1);
        final _number = (index/2).floor();
        final _memo = _memoList(_number);
        return Dismissible(  
          background: Container(color: Colors.red),
          key: Key(_memo),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              _memoList.removeAt(_number);
              storeMemoList();
            });
          },
          child: ListTile(
            title: Text(
              _memo,
              style: TextStyle(fontSize: 20),
              maxLines: 1,
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
    const key = 'memo-list';
    final _success = await _sharedPreferences.setStringList(key, _memoList);
    if (!_success) {
      debugPrint('Failed to store value');
    }
  }


}