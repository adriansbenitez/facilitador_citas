import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/widgets/app_service_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ads.dart';
import '../../config/routes.dart';
import '../../utils/utils.dart';
import 'home_sliver_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    AppBloc.homeCubit.onLoad();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
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

  ///Build Banner Ads
  Widget _buildBanner() {
    if (_bannerAd != null) {
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }
    return Container();
  }

  Future<void> _onRefresh() async {
    await AppBloc.homeCubit.onLoad();
  }

  ///On navigate service detail
  void _onProductDetail(SingleServiceModel item) {
    Navigator.pushNamed(context, Routes.serviceDetails, arguments: item.id);
  }

  ///On select location
  void _onTapServiceLocation(SingleLocationModel item) {
    Navigator.pushNamed(context, Routes.listServices, arguments: item);
  }

  Widget _buildLocation(LocationModel? location) {
    ///Loading
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppCategory(
            type: CategoryView.cardLarge,
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );

    if (location != null) {
      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = location.response[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppCategory(
              item: item,
              type: CategoryView.cardLarge,
              onPressed: () {
                _onTapServiceLocation(item);
              },
            ),
          );
        },
        itemCount: location.response.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate(
                  'popular_location',
                ),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 2),
              Text(
                Translate.of(context).translate(
                  'let_find_interesting',
                ),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Container(
          height: 195,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  Widget _buildRecentServices(ServicesModel? services) {
    ///Loading
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppServiceItem(type: ServiceViewType.small),
        );
      },
      itemCount: 8,
    );

    if (services != null) {
      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final service = services.singleServices[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppServiceItem(
              onPressed: () {
                _onProductDetail(service);
              },
              item: service,
              type: ServiceViewType.small,
            ),
          );
        },
        itemCount: services.singleServices.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('recent_location'),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  Translate.of(context).translate(
                    'what_happen',
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content,
        ),
      ],
    );
  }

  ///On search services
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        BannerModel? banner;
        LocationModel? location;
        ServicesModel? service;

        if (state is HomeSuccess) {
          banner = state.banner;
          location = state.location;
          service = state.recentsServices;
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: AppBarHomeSliver(
                expandedHeight: 250,
                banner: banner,
                onSearch: _onSearch,
              ),
              pinned: true,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: _onRefresh,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SafeArea(
                  top: false,
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15),
                      _buildLocation(location),
                      const SizedBox(height: 15),
                      //_buildBanner(),
                      _buildRecentServices(service),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            )
          ],
        );
      },
    ));
  }
}
