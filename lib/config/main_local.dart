import '../core/main_configured.dart';
import 'config.dart';

void main() {
  Config.setEnvironment(Environment.local);
  mainDelegate();
}
