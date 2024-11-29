import 'dart:io';
import 'package:dart_modules/constants/constants.dart';
import 'package:dart_modules/core/api_routes.dart';
import 'package:dart_modules/core/request.dart';

class RequestHandler {
  static handleRequest(HttpRequest request, Object module) async {
    ///RequestHandler
    dynamic myRequest = Request(request);
    final path = myRequest.path;
    final method = myRequest.method;
    if (method == GET && getRoutes.containsKey(path)) {
      final methodResult = getRoutes[path]!();
      request.response
        ..statusCode = HttpStatus.ok
        ..write(methodResult) // Write the result to the response
        ..close();
    } else if (method == POST && postRoutes.containsKey(path)) {
      final methodResult = postRoutes[path]!();
      request.response
        ..statusCode = HttpStatus.created
        ..write(methodResult) // Write the result to the response
        ..close();
    } else if (method == PUT && putRoutes.containsKey(path)) {
      final methodResult = putRoutes[path]!();
      request.response
        ..statusCode = HttpStatus.ok
        ..write(methodResult) // Write the result to the response
        ..close();
    } else if (method == PATCH && patchRoutes.containsKey(path)) {
      final methodResult = patchRoutes[path]!();
      request.response
        ..statusCode = HttpStatus.ok
        ..write(methodResult) // Write the result to the response
        ..close();
    } else if (method == DELETE && deleteRoutes.containsKey(path)) {
      final methodResult = deleteRoutes[path]!();
      request.response
        ..statusCode = HttpStatus.ok
        ..write(methodResult) // Write the result to the response
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not found') //Route not found error
        ..close();
    }
  }

  static invalid(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.notFound
      ..write('Error: Invalid Configuration !') //Invalid Configuration
      ..close();
  }
}
