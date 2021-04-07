import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lr_app_versioning/app_versioning.dart';

import 'service_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appVersioning = ServiceProvider.appVersioning;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(
        appVersioning: appVersioning,
      ),
    );
  }
}

class Home extends StatefulWidget {
  final AppVersioning appVersioning;

  const Home({Key key, this.appVersioning}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String minAppVersion;
  String currentAppVersion;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getApiVersioning();
  }

  void _getApiVersioning() async {
    minAppVersion = null;
    currentAppVersion = null;

    setState(() {
      isLoading = true;
    });

    // Get Api Versioning (just to show on screen)
    final apiVersioning = await widget.appVersioning.getMinimumApiVersion();
    setState(() {
      minAppVersion = apiVersioning.toString();
      isLoading = false;
    });

    // Get App Version (just to show on screen)
    final appVersion = await widget.appVersioning.getCurrentAppVersion();
    setState(() {
      currentAppVersion = appVersion.toString();
      isLoading = false;
    });

    // Check Update Required
    final isUpdateRequired = await widget.appVersioning.isUpdateRequired();
    if (isUpdateRequired) {
      _showUpdatePopup();
    }
  }

  _showUpdatePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
        child: Column(
          children: [
            Text("Update required!"),
            FlatButton(
              onPressed: () => widget.appVersioning.launchUpdate(),
              child: Text("OK"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Versioning Example')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Current Versioning Values',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Min Version: $minAppVersion',
                ),
                Text(
                  'Current Version: $currentAppVersion',
                ),
              ],
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getApiVersioning(),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
