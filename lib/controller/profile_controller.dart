import 'package:aqueduct/aqueduct.dart';
import 'package:portikko_webapp_api/model/user.dart';

class ProfileController extends ResourceController {
  ProfileController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getProfile() async {
    final id = request.authorization.ownerID;
    final query = Query<User>(context)..where((u) => u.id).equalTo(id);
    return Response.ok(await query.fetchOne());
  }
}
