import 'package:dart_modules/common/module.dart';
import 'app.controller.dart';
import 'app.service.dart';

@Module(
  imports: [],
  controllers: [AppController],
  providers: [AppService],
)
class AppModule {}
