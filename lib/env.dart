import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WEB_API_KEY', obfuscate: true)
  static final String webApiKey = _Env.webApiKey;
  @EnviedField(varName: 'ANDROID_API_KEY', obfuscate: true)
  static final String androidApiKey = _Env.androidApiKey;
  @EnviedField(varName: 'IOS_API_KEY', obfuscate: true)
  static final String iosApiKey = _Env.iosApiKey;
}