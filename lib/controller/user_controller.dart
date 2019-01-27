import 'package:portikko_webapp_api/portikko_webapp_api.dart';

class UserController extends ResourceController {
  @Operation.get()
  Future<Response> getAll() async {
    return Response.ok({"message": "works"});
  }

  @Operation.post()
  Future<Response> createUser() async {
    final Map<String, dynamic> data = await request.body.decode();
    return Response.ok({"message": "works"});
  }
}
