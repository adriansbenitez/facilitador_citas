import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc.dart';
import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _textEmailController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String? _errorEmail;
  String? _errorPass;

  @override
  void initState() {
    super.initState();
    super.initState();
  }

  @override
  void dispose() {
    _textEmailController.dispose();
    _textPassController.dispose();
    _focusEmail.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  ///On navigate forgot password
  void _forgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  ///On navigate sign up
  void _signUp() {
    Navigator.pushNamed(context, Routes.signUp);
  }

  ///On login
  void _login() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorEmail = UtilValidator.validate(_textEmailController.text,
          type: ValidateType.email);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorEmail == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textEmailController.text,
        password: _textPassController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, login) {
          if (login == LoginState.success) {
            AppBloc.applicationCubit.login();
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text('LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor)),
                  Image.asset(
                    Images.login,
                  ),
                  AppTextInput(
                    hintText: Translate.of(context).translate('account'),
                    errorText: _errorEmail,
                    controller: _textEmailController,
                    focusNode: _focusEmail,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      setState(() {
                        _errorEmail = UtilValidator.validate(
                            _textEmailController.text,
                            type: ValidateType.email);
                      });
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                          context, _focusEmail, _focusPass);
                    },
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textEmailController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextInput(
                    hintText: Translate.of(context).translate('password'),
                    errorText: _errorPass,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      setState(() {
                        _errorPass = UtilValidator.validate(
                          _textPassController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      _login();
                    },
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    obscureText: !_showPassword,
                    controller: _textPassController,
                    focusNode: _focusPass,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, login) {
                      return AppButton(
                        Translate.of(context).translate('sign_in'),
                        mainAxisSize: MainAxisSize.max,
                        onPressed: _login,
                        loading: login == LoginState.loading,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AppButton(
                        Translate.of(context).translate('forgot_password'),
                        onPressed: _forgotPassword,
                        type: ButtonType.text,
                      ),
                      AppButton(
                        Translate.of(context).translate('sign_up'),
                        onPressed: _signUp,
                        type: ButtonType.text,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
