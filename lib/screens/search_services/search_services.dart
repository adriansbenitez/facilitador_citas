import 'dart:convert';

import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/screens/screen.dart';
import 'package:flutter/material.dart';

import '../../blocs/bloc.dart';
import '../../config/config.dart';
import '../../utils/utils.dart';

class SearchServices extends StatefulWidget {
  const SearchServices({Key? key}) : super(key: key);

  @override
  _SearchServicesState createState() {
    return _SearchServicesState();
  }
}

class _SearchServicesState extends State<SearchServices> {
  late SearchHistoryDelegate _delegate;

  List<SingleServiceModel> _history = [];

  @override
  void initState() {
    super.initState();
    _delegate = SearchHistoryDelegate();
    _loadHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Load history
  void _loadHistory() async {
    List<String>? historyString = Preferences.getStringList(
      Preferences.search,
    );
    if (historyString != null) {
      _history = historyString.map((e) {
        final decodedMap = json.decode(json.decode(e));
        return SingleServiceModel.fromMap(decodedMap);
      }).toList();
    }
    setState(() {});
  }

  ///onShow search
  void _onSearch() async {
    AppBloc.searchCubit.onClear();
    await showSearch(
      context: context,
      delegate: _delegate,
    );
  }

  void _onClear({SingleServiceModel? item}) async {
    if (item == null) {
      await Preferences.setStringList(Preferences.search, []);
    } else {
      List<String>? historyString = Preferences.getStringList(
        Preferences.search,
      );
      if (historyString != null) {
        historyString.remove(jsonEncode(item.toJson()));
        await Preferences.setStringList(
          Preferences.search,
          historyString,
        );
      }
    }
    _loadHistory();
  }

  ///On navigate product detail
  void _onProductDetail(SingleServiceModel item) async {
    Navigator.pushNamed(context, Routes.serviceDetails, arguments: item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _delegate.transitionAnimation,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(Translate.of(context).translate('search_title')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHistory,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Translate.of(context).translate('search_service'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        _onClear();
                      },
                      child: Text(
                        Translate.of(context).translate('clear'),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: _history.map((item) {
                    return InputChip(
                      onPressed: () {
                        _onProductDetail(item);
                      },
                      label: Text(item.name, style: const TextStyle(color: Colors.white),),
                      onDeleted: () {
                        _onClear(item: item);
                      },
                      backgroundColor: Theme.of(context).primaryColor,

                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchHistoryDelegate extends SearchDelegate<String> {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    AppBloc.searchCubit.onSearch(query);
    return const SuggestionList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return const ResultList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];
    }
    return [];
  }
}
