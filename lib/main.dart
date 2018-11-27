import 'package:flutter/material.dart';
import 'dart:async';
import 'package:meta/meta.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Loading Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Progress Loading Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;

  @override
  void initState() {
    _simulateHeavyWork();
    super.initState();
  }

  void _simulateHeavyWork() {
    setState(() => _loading = true);
    final Duration timeout = Duration(seconds: 2);
    Timer(timeout, () => setState(() => _loading = false));
  }

  Widget progressView({
    @required bool asyncLoaded,
    @required Widget child,
  }) {
    Container loadingContainer = Container(
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    return asyncLoaded ? loadingContainer : child;
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loading ? Text("불러오는 중") : Text("불러오기 완료"),
          RaisedButton(
            child: Text("무거운 작업 시작"),
            onPressed: () => _simulateHeavyWork(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: progressView(
          asyncLoaded: _loading,
          child: _buildBody(),
        ),
      ),
    );
  }
}
