import 'package:aqueduct/managed_auth.dart';
import 'package:portikko_webapp_api/portikko_webapp_api.dart';

class User extends ManagedObject<_User>
    implements ManagedAuthResourceOwner<_User>, _User {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {
  @Column(omitByDefault: true)
  String username;

  @Column(nullable: true)
  String name;

  @Column(nullable: true)
  String surnames;

  @Column(unique: true, nullable: false)
  String email;

  @Column(nullable: false)
  bool active;

  @Column(indexed: true, nullable: false)
  DateTime createdAt;

  @Column(indexed: true, nullable: false)
  DateTime updatedAt;
}
