import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: "API_Url", obfuscate: true)
  static final String apiUrl = _Env.apiUrl;
}
