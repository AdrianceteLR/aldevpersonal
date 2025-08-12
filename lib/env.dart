class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );
  
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'AldevPersonal',
  );
  
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
  
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );
}