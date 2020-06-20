import 'package:flutter/material.dart';
import 'package:flutterwebinar/providers/items.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import '../providers/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _items = [];
  bool _isLoading = false;
  bool _isExpanded = false;

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Items>(context, listen: false)
          .getItems(Provider.of<Auth>(context, listen: false).token);
      setState(() {
        _items = Provider.of<Items>(context, listen: false).items;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      // body: _isLoading
      //     ? CircularProgressIndicator()
      //     : ListView.builder(
      //         itemBuilder: (ctx, i) => ListTile(
      //           title: Text(_items[i]['name']),
      //           subtitle: Text(_items[i]['description']),
      //           onTap: () async {
      //             await Provider.of<Items>(context, listen: false).deleteItem(
      //               Provider.of<Auth>(context, listen: false).token,
      //               _items[i]['_id'],
      //             );
      //             getData();
      //           },
      //         ),
      //         itemCount: _items.length,
      //       ),
      body: Column(
        children: <Widget>[
          AnimatedContainer(
              duration: Duration(seconds: 5),
              color: Colors.red,
              height: _isExpanded ? 400 : 200,
              width: 500,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(_isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                  if (_isExpanded) Text('Visible Only if Expanded'),
                ],
              ))
        ],
      ),
    );
  }
}
