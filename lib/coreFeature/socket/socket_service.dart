import 'dart:async';

// ignore: library_prefixes
import 'package:core_kit/utils/app_log.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/coreFeature/notification/model/notification_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  SocketService._();

  late IO.Socket socket;
  final StreamController<NotificationModel> streamController =
      StreamController<NotificationModel>.broadcast();
  // Singleton pattern
  static final SocketService instance = SocketService._();

  // Connect to the Socket.IO server
  void connect({required String id}) {
    AppLogger.info(
      'SocketService.connect called with user ID: "$id"',
      tag: 'Socket',
    );
    if (id.isEmpty) {
      AppLogger.error(
        'SocketService.connect called with empty user ID! Aborting connection.',
        tag: 'Socket',
      );
      return;
    }

    socket = IO.io(
      ApiEndPoint.instance.domain,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    // Handle connection
    socket.on('connect', (_) {
      AppLogger.info(
        'Successfully connected to Socket.IO server. ID = $id, Domain = ${ApiEndPoint.instance.domain}',
        tag: 'Socket',
      );
    });

    //notification
    socket.on('notification::$id', (data) {
      AppLogger.info(
        'Received raw notification event for ID $id: $data',
        tag: 'Socket',
      );
      if (data != null) {
        try {
          final notification = NotificationModel.fromJson(data);
          AppLogger.info(
            'Parsed notification: ${notification.title} - ${notification.message}',
            tag: 'Socket',
          );
          streamController.add(notification);
          AppLogger.info(
            'Added notification to streamController. Has listeners: ${streamController.hasListener}',
            tag: 'Socket',
          );
        } catch (e, stack) {
          AppLogger.error(
            'Error parsing or adding notification to stream: $e\n$stack',
            tag: 'Socket',
          );
        }
      }
    });

    // Handle disconnection
    socket.on('disconnect', (_) {
      AppLogger.debug('Disconnected from Socket.IO server', tag: 'Socket');
    });

    // Handle errors
    socket.on('connect_error', (error) {
      AppLogger.error('Connection Error: $error', tag: 'Socket');
    });

    // Connect to the server
    socket.connect();

    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      AppLogger.info('Emitting register event for user ID: $id', tag: 'Socket');
      register(id: id);
    });
  }

  void register({required String id}) async {
    socket.emit('register', id);
  }

  // Disconnect from the server
  void disconnect() {
    try {
      AppLogger.info('Disconnecting SocketService...', tag: 'Socket');
      socket.disconnect();
      socket.dispose();
      AppLogger.debug(
        'Disconnected from server, stream has listeners: ${streamController.hasListener}',
        tag: 'Socket',
      );
    } catch (e) {
      AppLogger.error('Error disconnecting socket: $e', tag: 'Socket');
    }
  }
}
