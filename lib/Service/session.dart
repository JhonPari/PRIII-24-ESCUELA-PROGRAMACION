import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session {
  final storage = FlutterSecureStorage();

  Future<void> saveSession(String id, String name, String role) async {
    await storage.write(key: 'user_id', value: id);
    await storage.write(key: 'user_name', value: name);
    await storage.write(key: 'user_role', value: role);
  }

  Future<Map<String, String?>> getSession() async {
    return {
      'id': await storage.read(key: 'user_id'),
      'name': await storage.read(key: 'user_name'),
      'role': await storage.read(key: 'user_role'),
    };
  }

  Future<void> removeSession() async {
    await storage.delete(key: 'user_id');
    await storage.delete(key: 'user_name');
    await storage.delete(key: 'user_role');
  }
}