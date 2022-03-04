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

  const Home({required this.appVersioning});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppUpdateInfo? appUpdateInfo;

  bool isLoading = false;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startVersioningServices();
  }

  void _startVersioningServices() async {
    setState(() {
      isLoading = true;
    });

    await Future.wait(
      [
        _getAppVersioning(),
        _trackVersions(),
      ],
    );

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getAppVersioning() async {
    // Get Api Versioning (just to show on screen)
    final appUpdateInfo = await widget.appVersioning.getAppUpdateInfo();
    setState(() {
      this.appUpdateInfo = appUpdateInfo;
    });

    // Check Update Available
    if (appUpdateInfo.isUpdateAvailable) {
      _showUpdatePopup(appUpdateInfo.updateType == AppUpdateType.Mandatory);
    }
  }

  Future<void> _trackVersions() async {
    await widget.appVersioning.tracker.track();
  }

  _showUpdatePopup(bool isMandatory) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
        child: Column(
          children: [
            Text(isMandatory ? "Update required!" : "Optional update"),
            TextButton(
              onPressed: () {
                widget.appVersioning
                    .launchUpdate(updateInBackground: !isMandatory);
              },
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
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Stack(
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
                      'Minimum Version: ${appUpdateInfo?.minimumVersion}',
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
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Version Tracking Status',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Is first launch ever: ${widget.appVersioning.tracker.isFirstLaunchEver}',
                    ),
                    Text(
                      'Is first launch for current version: ${widget.appVersioning.tracker.isFirstLaunchForCurrentVersion}',
                    ),
                    Text(
                      'Is first launch for current build: ${widget.appVersioning.tracker.isFirstLaunchForCurrentBuild}',
                    ),
                    Text(
                      'Version history: ${widget.appVersioning.tracker.versionHistory}',
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(
          () {
            _currentIndex = index;
          },
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics,
            ),
            label: "App versioning",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Version tracker",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startVersioningServices,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
