import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/list_pagination/list_empty_view.dart';
import 'package:skybase/ui/widgets/list_pagination/error_view.dart';
import 'package:skybase/ui/widgets/shimmer_list.dart';

class SkyListView extends StatefulWidget {
  /// Can override setting Visibility emptyView even if [emptyEnabled] is true
  final bool visibleOnEmpty;

  /// Can override setting Visibility emptyView even if [errorEnabled] is true
  final bool visibleOnError;

  /// Show [loadingView] when set to *true*
  final bool loadingEnabled;

  /// Show [emptyView] when set to *true*
  final bool emptyEnabled;

  /// Show [errorView] when set to *true*
  final bool errorEnabled;

  /// Loading view that will show if [loadingEnabled] is true
  final Widget? loadingView;

  /// Image that will show if [emptyEnabled] is true
  final Widget? emptyImage;

  /// Title that will show if [emptyEnabled] is true
  final String? emptyTitle;

  /// Subtitle that will show if [emptyEnabled] is true
  final String? emptySubtitle;

  /// Image that will show if [errorEnabled] is true
  final Widget? errorImage;

  /// Title that will show if [errorEnabled] is true
  final String? errorTitle;

  /// Subtitle that will show if [errorEnabled] is true
  final String? errorSubtitle;

  /// Set scrollable of your empty/error view
  final bool isComponent;

  /// Function to controll onPress 'retry' if [errorEnabled] is true
  final void Function()? onRetry;

  final Widget child;

  const SkyListView({
    Key? key,
    required this.child,
    required this.emptyEnabled,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.onRetry,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.loadingView,
    this.visibleOnEmpty = true,
    this.visibleOnError = true,
    this.errorImage,
    this.errorSubtitle,
    this.errorTitle,
    this.isComponent = true,
  }) : super(key: key);

  @override
  _SkyListViewState createState() => _SkyListViewState();
}

class _SkyListViewState extends State<SkyListView> {
  @override
  Widget build(BuildContext context) {
    var loadingWidget = widget.loadingView ?? const ShimmerList();

    return Stack(
      children: [
        getBodyWidget(),
        getErrorView(),
        getEmptyView(),
        getLoadingView(loadingWidget),
      ],
    );
  }

  Widget getBodyWidget() =>
      widget.loadingEnabled || widget.emptyEnabled || widget.errorEnabled
          ? Container()
          : widget.child;

  Widget getLoadingView(Widget loadingWidget) => widget.loadingEnabled
      ? Center(
          child: AnimatedOpacity(
            opacity: widget.loadingEnabled ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: loadingWidget,
          ),
        )
      : Container();

  Widget getEmptyView() => widget.visibleOnEmpty &&
          widget.emptyEnabled &&
          !widget.errorEnabled &&
          !widget.loadingEnabled
      ? ListEmptyView(
          emptyImage: widget.emptyImage,
          emptyTitle: widget.emptyTitle,
          emptySubtitle: widget.emptySubtitle,
          isScrollable: widget.isComponent,
        )
      : Container();

  Widget getErrorView() => widget.visibleOnError && widget.errorEnabled
      ? ErrorView(
          errorImage: widget.errorImage,
          errorTitle: widget.errorTitle,
          errorSubtitle: widget.errorSubtitle,
          onRetry: widget.onRetry,
          isScrollable: widget.isComponent,
        )
      : Container();
}
