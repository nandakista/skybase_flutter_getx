import 'package:get/get.dart';
import 'package:skybase/data/repositories/auth/auth_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_controller.dart';
import 'package:skybase/ui/views/profile/profile_controller.dart';

class ProfileBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(
          () => ProfileController(
            repository: AuthRepositoryImpl(apiService: AuthSourcesImpl()),
          ),
        ),
        Bind.lazyPut(
          () => ProfileRepositoryController(
            repository: AuthRepositoryImpl(apiService: AuthSourcesImpl()),
          ),
        ),
      ];
}
