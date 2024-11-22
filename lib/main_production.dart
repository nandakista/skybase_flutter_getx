import './main.dart' as main_app;
import 'config/environment/app_env.dart';
import 'config/environment/config_data.dart';
import 'config/network/api_token_manager.dart';
import 'dev/dev_token.dart';

void main() async {
  AppEnv.set(
    environment: Environment.PRODUCTION,
    configuration: ConfigData(
      baseUrl: 'https://api.github.com',
      tokenType: TokenType.ACCESS_TOKEN,
      clientToken: gitToken,
    ),
  );
  main_app.main();
}
