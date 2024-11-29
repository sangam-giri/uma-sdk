import 'dart:io';

class ConfigModule {
  static Map<String, String> forRoot(
      {String envFilePath = '.env', bool isGlobal = true}) {
    final envFile = File(envFilePath);
    final lines = envFile.readAsLinesSync();
    final env = <String, String>{};

    for (final line in lines) {
      final parts = line.split('=');
      if (parts.length == 2) {
        env[parts[0].trim()] = parts[1].trim();
      }
    }

    return env;
  }
}

//TODO(Sangam): Validate and Optimize the accessing logic
///
// Map<String, String> loadEnv() {
//   final envFile = File('.env');
//   final lines = envFile.readAsLinesSync();
//   final env = <String, String>{};

//   for (final line in lines) {
//     final parts = line.split('=');
//     if (parts.length == 2) {
//       env[parts[0].trim()] = parts[1].trim();
//     }
//   }
//   return env;
// }



  // final env = loadEnv();
  // print(env['DATABASE_URL']);
  // print(env['API_KEY']);
  // print(env['DEBUG']);