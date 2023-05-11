import 'config/config.dart';
import 'core/main_configured.dart';

void main() {
  Config.setEnvironment(Environment.dev);
  mainDelegate();
}
