import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/list_pagination/error_view.dart';
import 'package:skybase/ui/widgets/shimmer_detail.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyView extends StatelessWidget {
  const SkyView({
    Key? key,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.onRetry,
    required this.child,
    this.loadingView,
    this.errorView,
    this.errorMsg,
  }) : super(key: key);

  final bool loadingEnabled;
  final bool errorEnabled;
  final Widget? loadingView;
  final Widget? errorView;
  final Widget child;
  final String? errorMsg;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _iosObjectView();
    } else {
      return _androidObjectView();
    }
  }

  Widget _androidObjectView() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(onRetry),
        child: SingleChildScrollView(
          child: loadingEnabled
              ? loadingView ?? const ShimmerDetail()
              : (errorEnabled)
                  ? errorView ??
                      ErrorView(
                        isScrollable: false,
                        errorSubtitle: errorMsg,
                        onRetry: onRetry,
                      )
                  : child,
        ),
      ),
    );
  }

  Widget _iosObjectView() {
    return Center(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () => Future.sync(onRetry),
          ),
          SliverFillRemaining(
            child: loadingEnabled
                ? loadingView ?? const ShimmerDetail()
                : (errorEnabled)
                    ? errorView ??
                        ErrorView(
                          isScrollable: false,
                          errorSubtitle: errorMsg,
                          onRetry: onRetry,
                        )
                    : child,
          )
        ],
      ),
    );
  }
}
