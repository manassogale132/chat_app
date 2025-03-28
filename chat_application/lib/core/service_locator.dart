import 'package:chat_application/repositories/chat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_application/services/chat_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  // Repositories
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
}
