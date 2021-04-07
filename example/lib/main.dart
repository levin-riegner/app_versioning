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

  const Home({Key? key, required this.appVersioning}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppUpdateInfo? appUpdateInfo;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAppVersioning();
  }

  void _getAppVersioning() async {
    setState(() {
      isLoading = true;
    });

    // Get Api Versioning (just to show on screen)
    final appUpdateInfo = await widget.appVersioning.getAppUpdateInfo();
    setState(() {
      this.appUpdateInfo = appUpdateInfo;
      this.isLoading = false;
    });

    // Check Update Required
    final isUpdateRequired = appUpdateInfo.isUpdateAvailable &&
        appUpdateInfo.updateType == AppUpdateType.Mandatory;
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
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Current Version: ${appUpdateInfo?.currentVersion}',
                ),
                Text(
                  'Update Available: ${appUpdateInfo?.isUpdateAvailable}',
                ),
                Text(
                  'Update Type: ${appUpdateInfo?.updateType}',
                ),
              ],
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getAppVersioning(),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
