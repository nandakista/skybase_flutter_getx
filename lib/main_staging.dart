import './main.dart' as main_app;
import 'core/app/app_env.dart';

void main() async {
  AppEnv.set(Env.STAGING);
  main_app.main();
}