import 'package:aqueduct/managed_auth.dart';
import 'package:portikko_webapp_api/model/user.dart';
import 'portikko_webapp_api.dart';

class PortikkoWebappApiConfiguration extends Configuration {
  PortikkoWebappApiConfiguration(String fileName)
      : super.fromFile(File(fileName));
  DatabaseConfiguration database;
}

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class PortikkoWebappApiChannel extends ApplicationChannel {
  AuthServer authServer;
  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config =
        PortikkoWebappApiConfiguration(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);
    final delegate = ManagedAuthDelegate<User>(context, tokenLimit: 10);
    authServer = AuthServer(delegate);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router(basePath: '/api');

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    return router;
  }
}
