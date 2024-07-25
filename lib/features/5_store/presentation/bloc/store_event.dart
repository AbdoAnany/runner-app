import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class LoadStoreData extends StoreEvent {}

class RefreshStoreData extends StoreEvent {}

class LoadMorePopularProducts extends StoreEvent {}