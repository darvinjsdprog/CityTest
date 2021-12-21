import 'package:city_test/detailView.dart';
import 'package:city_test/loading.dart';
import 'package:city_test/widgets/masterView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Loading(),
              '/home': (context) => MyHomePage(title: 'City Test'),
              '/detail': (context) => DetailView(),
            },
            title: 'City Test',
            theme: ThemeData(
                primarySwatch: Colors.blue, primaryColor: Colors.white),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic country = ModalRoute.of(context)!.settings.arguments;
    return View(
      title: 'Ciudades',
      child: Container(
        child: ListView.builder(
            itemCount: country.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Material(
                  elevation: 5,
                  child: Container(
                    child: ListTile(
                      title: Text(toBeginningOfSentenceCase(
                          country[index]['country'])!),
                      subtitle: Text(
                          toBeginningOfSentenceCase(country[index]['name'])!),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail',
                            arguments: country[index]);
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
