import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/list_pagination/error_view.dart';
import 'package:skybase/ui/widgets/shimmer_detail.dart';

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
}
