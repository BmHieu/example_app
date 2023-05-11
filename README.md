# source_base
 All new MLTechSoft clean-architecture-lite source base
## Flutter Clean Architecture
![alt text](https://camo.githubusercontent.com/55853a69706aa99be6d5f6ffaf11d2bd5747d0338756ecefd93338b3fd687937/68747470733a2f2f692e6962622e636f2f5744466d7858422f6170702d6469616772616d2e706e67)



## Generate files (Assets)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Flutter Internationalization
```bash
flutter pub run easy_localization:generate --source-dir locales -f keys -o locale_keys.g.dart

```

## Dart Code Metrics
Use `dart_code_metrics` to generate code metrics reports.
```bash
dart run dart_code_metrics:metrics analyze lib --reporter=html
```

VSCode Extensions can be found in `.vscode/extensions.json`


## Requirements:
- No VSCode detected prolems upond commit
