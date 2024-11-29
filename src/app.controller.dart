import 'package:dart_modules/common/controller.dart';
import 'package:dart_modules/common/routes.dart';
import 'app.service.dart';

@Controller()
class AppController {
  AppService appService = AppService();

  @Get()
  String getMethod() {
    return appService.getMethod();
  }

  @Post()
  String postMethod() {
    return appService.postMethod();
  }

  @Put()
  String putMethod() {
    return appService.putMethod();
  }

  @Patch()
  String patchMethod() {
    return appService.patchMethod();
  }

  @Delete()
  String deleteMethod() {
    return appService.deleteMethod();
  }
}
