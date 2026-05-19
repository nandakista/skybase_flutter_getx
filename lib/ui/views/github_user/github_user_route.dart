import 'package:get/get.dart';
import 'package:skybase/ui/views/github_user/github_user_binding.dart';
import 'package:skybase/ui/views/github_user/github_user_view.dart';

final githubUserRoute = [
  GetPage(
    name: GithubUserView.route,
    page: () => const GithubUserView(),
    binding: GithubUserBinding(),
  ),
];
