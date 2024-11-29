import 'dart:io';

class Request {
  HttpRequest request;
  Request(this.request);

  get host => request.headers["host"]?.join();

  get authorization => request.headers["authorization"]?.join();

  get method => request.method;

  get path => request.uri.path;

  static Future<String> body(HttpRequest request) async {
    final bodyBytes = await request
        .fold<List<int>>([], (prev, element) => prev..addAll(element));
    return String.fromCharCodes(bodyBytes);
  }
}
