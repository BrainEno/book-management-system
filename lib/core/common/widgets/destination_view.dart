import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey as GlobalKey<NavigatorState>,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (widget.destination.index) {
              case 0:
                return const LoginPage();
              default:
                return const LoginPage();
            }
          },
        );
      },
    );
  }
}

class Destination {
  final int index;
  final String title;
  final IconData icon;
  final Color color;

  const Destination(this.index, this.title, this.icon, this.color);
}
