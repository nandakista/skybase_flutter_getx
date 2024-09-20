import 'package:get/get.dart';
import 'package:skybase/data/repositories/auth/auth_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/ui/views/login/login_controller.dart';

class LoginBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut(
          () => LoginController(
            repository: AuthRepositoryImpl(
              apiService: AuthSourcesImpl(),
            ),
          ),
        ),
      ];
}
