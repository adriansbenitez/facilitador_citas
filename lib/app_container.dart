import 'package:facilitador_citas/screens/screen.dart';
import 'package:facilitador_citas/utils/utils.dart';
import 'package:facilitador_citas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/bloc.dart';
import 'config/config.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  String _selected = Routes.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Build submit button
  Widget? _buildSubmit() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: null,
      child: const Icon(
        Icons.calendar_month,
        color: Colors.white,
      ),
    );
    return null;
  }

  ///On change tab bottom menu and handle when not yet authenticate
  void _onItemTapped(String route) async {
    /*final signed = AppBloc.authenticateCubit.state != AuthenticationState.fail;
    if (!signed && _requireAuth(route)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: route,
      );
      if (result == null) return;
    }*/
    setState(() {
      _selected = route;
    });
  }

  Widget _buildMenuItem(String route) {
    Color? color;
    String title = 'home';
    IconData iconData = Icons.help_outline;
    bool badge = false;
    switch (route) {
      case Routes.home:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
      case Routes.appointments:
        iconData = Icons.assignment;
        title = 'appointments';
        break;
      case Routes.chat:
        iconData = Icons.chat;
        title = 'chat';
        badge = true;
        break;
      case Routes.account:
        iconData = Icons.account_circle;
        title = 'account';
        break;
      default:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
    }
    if (route == _selected) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        _onItemTapped(route);
      },
      padding: EdgeInsets.zero,
      icon: AppBadge(
        amount: 3,
        showBadge: badge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              Translate.of(context).translate(title),
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: 10,
                    color: color,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomMenu() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuItem(Routes.home),
            _buildMenuItem(Routes.appointments),
            const SizedBox(width: 56),
            _buildMenuItem(Routes.chat),
            _buildMenuItem(Routes.account),
          ],
        ),
      ),
    );
  }

  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.appointments:
        return 1;
      case Routes.chat:
        return 2;
      case Routes.account:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    const submitPosition = FloatingActionButtonLocation.centerDocked;
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, authentication) async {
          // _listenAuthenticateChange(authentication);
        },
        child: IndexedStack(
          index: _exportIndexed(_selected),
          children: <Widget>[Home(), Appointments(), Chat(), Account()],
        ),
      ),
      bottomNavigationBar: _buildBottomMenu(),
      floatingActionButton: _buildSubmit(),
      floatingActionButtonLocation: submitPosition,
    );
  }
}
