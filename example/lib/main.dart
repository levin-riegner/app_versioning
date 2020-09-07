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
  String minIosVersion;
  String minAndroidVersion;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getApiVersioning();
  }

  void _getApiVersioning() async {
    minIosVersion = null;
    minAndroidVersion = null;

    setState(() {
      isLoading = true;
    });

    final apiVersioning = await widget.appVersioning.getApiVersioning();
    setState(() {
      minIosVersion = apiVersioning.minimumIosVersion;
      minAndroidVersion = apiVersioning.minimumAndroidVersion;
      isLoading = false;
    });
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
                  'iOS: $minIosVersion',
                ),
                Text(
                  'Android: $minAndroidVersion',
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
