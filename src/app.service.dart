import 'package:dart_modules/common/injectable.dart';

@Injectable()
class AppService {
  String getMethod() {
    return 'Get Method Working';
  }

  String postMethod() {
    return 'Post Method Working';
  }

  String putMethod() {
    return 'Put Method Working';
  }

  String patchMethod() {
    return 'Patch Method Working';
  }

  String deleteMethod() {
    return 'Delete Method Working';
  }
}
