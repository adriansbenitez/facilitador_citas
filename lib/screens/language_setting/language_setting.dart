
import 'package:flutter/material.dart';
import '../../blocs/bloc.dart';
import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  _LanguageSettingState createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {

  List<Locale> _listLanguage = AppLanguage.supportLanguage;
  Locale _languageSelected = AppBloc.languageCubit.state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change language
  void _changeLanguage() async {
    UtilOther.hiddenKeyboard(context);
    AppBloc.languageCubit.onUpdate(_languageSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          Translate.of(context).translate('change_language'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = _listLanguage[index];
                  if (item == _languageSelected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: AppLanguage.getGlobalLanguageName(
                      item.languageCode,
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        _languageSelected = item;
                      });
                    },
                    border: index != _listLanguage.length - 1,
                  );
                },
                itemCount: _listLanguage.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _changeLanguage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
