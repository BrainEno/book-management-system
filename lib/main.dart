import 'package:bookstore_management_system/core/common/widgets/destination_view.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/init_dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书店管理系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, '首页', Icons.home, AppPallete.whiteColor),
    Destination(1, '商品', Icons.search, AppPallete.whiteColor),
    Destination(2, '销售', Icons.bookmark, AppPallete.whiteColor),
    Destination(3, '数据', Icons.person, AppPallete.whiteColor),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> desinationkeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((AnimationStatus status) {
      if (status.isDismissed) {
        setState(() {}); // Rebuild unselected destinations offstage.
      }
    });
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys =
        List<GlobalKey<NavigatorState>>.generate(
          allDestinations.length,
          (int index) => GlobalKey(),
        ).toList();

    destinationFaders =
        List<AnimationController>.generate(
          allDestinations.length,
          (int index) => buildFaderController(),
        ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews =
        allDestinations.map<Widget>((Destination destination) {
          return FadeTransition(
            opacity: destinationFaders[destination.index].drive(tween),
            child: DestinationView(
              destination: destination,
              navigatorKey: navigatorKeys[destination.index],
            ),
          );
        }).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      // ignore: deprecated_member_use
      onPop: () {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        home: Scaffold(
          body: SafeArea(
            top: false,
            child: Stack(
              fit: StackFit.expand,
              children:
                  allDestinations.map((Destination destination) {
                    final int index = destination.index;
                    final Widget view = destinationViews[index];
                    if (index == selectedIndex) {
                      destinationFaders[index].forward();
                      return Offstage(offstage: false, child: view);
                    } else {
                      destinationFaders[index].reverse();
                      if (destinationFaders[index].isAnimating) {
                        return IgnorePointer(child: view);
                      }
                      return Offstage(child: view);
                    }
                  }).toList(),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations:
                allDestinations.map<NavigationDestination>((
                  Destination destination,
                ) {
                  return NavigationDestination(
                    icon: Icon(destination.icon, color: destination.color),
                    label: destination.title,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
