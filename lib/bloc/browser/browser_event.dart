part of 'browser_bloc.dart';

sealed class BrowserEvent extends Equatable {
  const BrowserEvent();

  @override
  List<Object> get props => [];
}

final class AddTab extends BrowserEvent {
  final BrowserTabModel browserTabModel;

  const AddTab({required this.browserTabModel});
}

final class RemoveTab extends BrowserEvent {
  final int id;

  const RemoveTab({required this.id});
}

final class SetInitial extends BrowserEvent {}
