import 'package:portikko_webapp_api/model/user.dart';
import 'package:portikko_webapp_api/portikko_webapp_api.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    // TODO: Add logs
    // Check for required parameters before we spend time hashing
    if ((user.email == null || user.password == null) ||
        (user.email.isEmpty || user.password.isEmpty)) {
      return Response.badRequest(body: {
        "error": {
          "en": "email and password required.",
          "es": "email y password son campos requeridos."
        }
      });
    }

    // Check if user exists
    final query = Query<User>(context)
      ..where((u) => u.email).equalTo(user.email);
    final exists = await query.fetchOne();

    // If user exists return error
    if (exists != null) {
      return Response.badRequest(body: {
        "error": {
          "en": "User already exists.",
          "es": "Correo electrónico ya registrado."
        }
      });
    }

    // Register user
    user
      ..username = user.email
      ..active = true
      ..createdAt = DateTime.now().toUtc()
      ..updatedAt = DateTime.now().toUtc()
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    // Return registered user
    return Response.ok(await Query(context, values: user).insert());
  }
}
