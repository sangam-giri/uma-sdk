import 'package:dart_modules/core/core.dart';
import 'app.module.dart';

void main() {
  var app = DartFactory.create(AppModule);
  app.listen(3000);
}
