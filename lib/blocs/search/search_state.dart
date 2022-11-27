import 'package:facilitador_citas/models/models.dart';

abstract class SearchState {}

class InitialSearchState extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SingleServiceModel> list;

  SearchSuccess({required this.list});
}
