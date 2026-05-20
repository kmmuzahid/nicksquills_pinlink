/*
 * @Author: Km Muzahid 
 * @Date: 2026-01-07 12:17:01
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/app_bloc_observer.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/coreFeature/notification/local_notification_service.dart';
import 'package:pinlink/my_app..dart';

void main() async {
  Bloc.observer = AppBlocObserver();

  if (kDebugMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      debugPrint('Flutter error: ${details.exception}');
      return const Center(child: Text('Oops, something went wrong'));
    };
  }

  WidgetsFlutterBinding.ensureInitialized();

  await init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

Future<void> init() async {
  _diInit();
  await LocalNotificationService.instance.init();
  // await Future.wait([dotenv.load()]);
}

void _diInit() {
  final dI = DependencyInjection();
  dI.dependencies();
}
