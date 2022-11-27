import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  Widget child;
  bool showBadge;
  int amount;

  AppBadge({Key? key, required this.child, this.showBadge = true, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text('${amount}', style: TextStyle(color: Colors.white),),
      showBadge: showBadge,
      elevation: 4,
      badgeColor: Theme.of(context).primaryColor,
      animationType: BadgeAnimationType.scale,
      child: child,
    );
  }
}
