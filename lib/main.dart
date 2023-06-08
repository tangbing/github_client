import 'package:flutter/material.dart';
import 'package:github_client_app/routes/home_page.dart';
import 'package:github_client_app/routes/language.dart';
import 'package:github_client_app/routes/login.dart';
import 'package:github_client_app/routes/theme_change.dart';
import 'package:github_client_app/states/profile_change_notifier.dart';
import 'common/global.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/localization_intl.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
       child: Consumer2<ThemeModel, LocaleModel>(
         builder: (BuildContext context, themeModel, localeModel, child) {
           return MaterialApp(
             theme: ThemeData(

               primarySwatch: getaterialColor(themeModel!.theme),
             ),
             onGenerateTitle: (context) {
               return GmLocalizations.of(context)?.title ?? "";
             },
              home: HomeRoute(),
             locale: localeModel.getLocale(),
             supportedLocales: [
               const Locale('en', 'US'),
               const Locale('zh', 'CN'),
             ],
             localizationsDelegates: [
               // 本地化的代理类
               GlobalMaterialLocalizations.delegate,
               GlobalWidgetsLocalizations.delegate,
               GmLocalizationsDelegate()
             ],
             localeResolutionCallback: (_locale ,supportedLocales) {
               if (localeModel.getLocale() != null) {
                   return localeModel.getLocale();
               } else {
                 //跟随系统
                  Locale? locale;
                  if (supportedLocales.contains(_locale)) {
                    locale = _locale;
                  } else {
                    //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                    locale = Locale('en', 'US');
                  }
                  return locale;
               }
             },
             // 注册路由
             routes: <String, WidgetBuilder> {
               "login": (context) => const LoginRoute(),
               "themes": (context) => const ThemeChangeRoute(),
               "language": (context) => const LanguageRoute(),
             },
           );
         },
       ),
    );
  }

  MaterialColor getaterialColor(ColorSwatch themeModel) {
    return MaterialColor(themeModel.value, <int, Color>{
      50: themeModel[50]!,
      100: themeModel[100]!,
      200: themeModel[200]!,
      300: themeModel[300]!,
      400: themeModel[400]!,
      500: themeModel[500]!,
      600: themeModel[600]!,
      700: themeModel[700]!,
      800: themeModel[800]!,
      900: themeModel[900]!,
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
