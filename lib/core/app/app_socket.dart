import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;
import 'package:skybase/core/app/app_env.dart';

class AppSocket {
  static AppSocket get find => Get.find<AppSocket>();
  static socket.Socket get io => Get.find<AppSocket>().init();

  socket.Socket init() {
    return socket.io(
      AppEnv.find.get.socketUrl,
      socket.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // for Flutter or Dart VM
          .build(),
    );
  }

  void interceptor() {
    if(kDebugMode) {
      AppSocket.io.onConnect((data) {
        debugPrint('<------------< SOCKET >--------------->');
        debugPrint('Socket Connected');
        debugPrint('Socket ID = ${AppSocket.io.id}');
        debugPrint('Socket Headers = ${AppSocket.io.opts}');
        debugPrint('<------------------------------------->');
      });

      AppSocket.io.onDisconnect((data) {
        debugPrint('<------------< SOCKET >--------------->');
        debugPrint('Socket Disconnected');
        debugPrint('<------------------------------------->');
      });
    }
  }

  void login({required String email}) {
    AppSocket.io.connect();
    try {
      AppSocket.io.onConnect((data) => AppSocket.io.emit('login', email));
    } catch (err) {
      debugPrint('Socket Error : $err');
    }
  }

  void logout() => AppSocket.io.dispose();

}
