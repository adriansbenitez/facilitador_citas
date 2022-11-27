import 'package:flutter/material.dart';
import '../../blocs/app_bloc.dart';
import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  Images.logo,
                  width: 350,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 300),
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2),
            ),
          )
        ],
      ),
    );
  }
}
