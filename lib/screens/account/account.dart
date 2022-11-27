import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../blocs/bloc.dart';
import '../../config/config.dart';
import '../../utils/utils.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  ///Create BannerAd
  void _createBannerAd() {
    final banner = BannerAd(
      size: AdSize.fullBanner,
      request: const AdRequest(),
      adUnitId: Ads.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      ),
    );
    banner.load();
  }

  ///Create InterstitialAd
  void _createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: Ads.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  ///Show InterstitialAd
  void _showInterstitialAd() async {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      await _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  ///On logout
  void _onLogout() async {
    onLogoutDiaglog();
  }

  void _logout() async {
    _showInterstitialAd();
    AppBloc.loginCubit.onLogout();
    AppBloc.applicationCubit.logout();
  }

  void onLogoutDiaglog() async {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      desc: Translate.of(context).translate('logout_message').toUpperCase(),
      btnCancelOnPress: () {},
      btnCancelIcon: Icons.cancel,
      btnOkOnPress: _logout,
      btnOkColor: Theme.of(context).primaryColor,
      btnOkIcon: Icons.logout,
      dismissOnTouchOutside: false,
    ).show();
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    Navigator.pushNamed(context, Routes.account, arguments: user);
  }

  ///Build Banner Ads
  Widget buildBanner() {
    if (_bannerAd != null) {
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('account'),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.notification_important_outlined),
              )),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserModel?>(
          builder: (context, user) {
            if (user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor.withOpacity(
                                .05,
                              ),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(
                            0,
                            2,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: AppUserInfo(
                      user: user,
                      type: UserViewType.information,
                      onPressed: () {
                        _onProfile(user);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: <Widget>[
                      AppListTitle(
                        title: Translate.of(context).translate(
                          'edit_profile',
                        ),
                        trailing: RotatedBox(
                          quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                        onPressed: () {
                          _onNavigate(Routes.editProfile);
                        },
                      ),
                      AppListTitle(
                        title: Translate.of(context).translate(
                          'change_password',
                        ),
                        trailing: RotatedBox(
                          quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                        onPressed: () {
                          _onNavigate(Routes.changePassword);
                        },
                      ),
                      AppListTitle(
                        title: Translate.of(context).translate('setting'),
                        onPressed: () {
                          _onNavigate(Routes.setting);
                        },
                        trailing: RotatedBox(
                          quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                        border: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: AppButton(
                      Translate.of(context).translate('logout'),
                      mainAxisSize: MainAxisSize.max,
                      onPressed: _onLogout,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
