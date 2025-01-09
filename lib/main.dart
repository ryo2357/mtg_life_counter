import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:flutter/services.dart';

// import 'package:mtg_life_counter/util/color/darken.dart';
// import 'package:mtg_life_counter/static_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FullScreen.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool settingsReady = false;
  bool get ready => settingsReady;

  String? waitingUri;

  // 指定されたURLへの直接遷移機能
  // late AppLinks _appLinks;

  // void mtgDataOnLoad() {
  //   setState(() {});
  // }

  // セッティングサービスのビルド
  // void loadSettingsService() async {
  //   Service.settingsService = await SettingsService.build();
  //   setState(() {
  //     settingsReady = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        var seedColor = darkDynamic?.primary ?? Colors.green;
        var colorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );
        return MaterialApp(
          // title: Service.appName,
          title: "test",
          theme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: true,
          ),
          home: ready
              // ? LifeCounterPage(
              //     waitingUri: waitingUri,
              //     onUriConsumed: () {
              //       setState(() {
              //         waitingUri = null;
              //       });
              //     },
              //   )
              ? const MyPage()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          // home: const MyPage(),
        );
      },
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with FullScreenListener {
  bool isFullScreen = FullScreen.isFullScreen;

  @override
  void initState() {
    FullScreen.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    FullScreen.removeListener(this);
    super.dispose();
  }

  @override
  void onFullScreenChanged(bool enabled, SystemUiMode? systemUiMode) {
    setState(() {
      isFullScreen = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    // フルスクリーンモードを有効にする
    FullScreen.setFullScreen(true);

    return Scaffold(
      appBar: AppBar(
        title: Text('FullScreen Example'),
      ),
      body: Center(
        child:
            Text(isFullScreen ? 'FullScreen Enabled' : 'FullScreen Disabled'),
      ),
    );
  }
}
