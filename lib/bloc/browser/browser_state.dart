part of 'browser_bloc.dart';

class BrowserState {
  final List<BrowserTabModel> browserTabs;

  const BrowserState({required this.browserTabs});

  BrowserState copyWith(List<BrowserTabModel>? browserTabs) {
    return BrowserState(
      browserTabs: browserTabs ?? this.browserTabs,
    );
  }
}
