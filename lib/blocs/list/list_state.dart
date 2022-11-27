import 'package:facilitador_citas/models/models.dart';

abstract class ListState {}

class ListLoading extends ListState {}

class ListSuccess extends ListState {
  final List<SingleServiceModel> list;
  final bool canLoadMore;
  final bool loadingMore;

  ListSuccess({
    required this.list,
    required this.canLoadMore,
    this.loadingMore = false,
  });
}
