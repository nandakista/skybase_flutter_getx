/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/base/empty_view.dart';
import 'package:skybase/ui/widgets/base/error_view.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

// ignore: non_constant_identifier_names
PagedChildBuilderDelegate<T> PaginationDelegate<T>({
  required PagingController<int, T> pagingController,
  required ItemWidgetBuilder<T> itemBuilder,
  required VoidCallback onRetry,
  Widget? loadingView,
  Widget? emptyView,
  Widget? emptyImageWidget,
  String? emptyImage,
  String? emptyTitle,
  String? emptySubtitle,
  Widget? errorImageWidget,
  String? errorImage,
  String? errorTitle,
  String? errorSubtitle,
  double? imageHeight,
  double? imageWidth,
  double? verticalSpacing,
  double? horizontalSpacing,
  TextStyle? emptyTitleStyle,
  TextStyle? emptySubtitleStyle,
  bool emptyRetryEnabled = false,
  Widget? errorView,
  Widget? errorLoadMoreView,
  String? retryText,
  Widget? retryWidget,
  TextStyle? errorTitleStyle,
  TextStyle? errorSubtitleStyle,
  Widget? maxItemView,
}) {
  return PagedChildBuilderDelegate<T>(
    animateTransitions: true,
    newPageProgressIndicatorBuilder: (ctx) => const Padding(
      padding: EdgeInsets.all(24.0),
      child: PlatformLoadingIndicator(),
    ),
    firstPageProgressIndicatorBuilder: (ctx) =>
        loadingView ??
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: PlatformLoadingIndicator(),
        ),
    noItemsFoundIndicatorBuilder: (ctx) =>
        emptyView ??
        EmptyView(
          emptyImage: emptyImage,
          emptyImageWidget: emptyImageWidget,
          emptyTitle: emptyTitle,
          emptySubtitle: emptySubtitle,
          titleStyle: emptyTitleStyle,
          subtitleStyle: emptySubtitleStyle,
          horizontalSpacing: horizontalSpacing ?? 24,
          verticalSpacing: verticalSpacing ?? 24,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          emptyRetryEnabled: emptyRetryEnabled,
          onRetry: () {
            pagingController.refresh();
            onRetry();
          },
          physics: const NeverScrollableScrollPhysics(),
        ),
    firstPageErrorIndicatorBuilder: (ctx) =>
        errorView ??
        ErrorView(
          errorImage: errorImage,
          errorImageWidget: errorImageWidget,
          errorTitle:
              '${errorTitle ?? pagingController.error ?? 'txt_err_general_formal'.tr}',
          errorSubtitle: errorSubtitle,
          horizontalSpacing: horizontalSpacing ?? 24,
          verticalSpacing: verticalSpacing ?? 24,
          titleStyle: errorTitleStyle,
          subtitleStyle: errorSubtitleStyle,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          retryText: retryText,
          retryWidget: retryWidget,
          physics: const BouncingScrollPhysics(),
          onRetry: () {
            pagingController.retryLastFailedRequest();
            onRetry();
          },
        ),
    noMoreItemsIndicatorBuilder: (ctx) =>
        maxItemView ?? const SizedBox.shrink(),
    newPageErrorIndicatorBuilder: (ctx) =>
        errorLoadMoreView ??
        InkWell(
          onTap: onRetry,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: errorLoadMoreView ?? const Icon(CupertinoIcons.refresh),
              ),
              Text('txt_tap_retry'.tr)
            ],
          ),
        ),
    itemBuilder: itemBuilder,
  );
}
