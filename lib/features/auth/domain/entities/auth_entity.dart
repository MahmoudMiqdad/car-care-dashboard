class AdminEntity {
  final int? id;
  final String? uuid;
  final String? name;
  final String? email;
  final String? phone;
  final String? status;
  final List<AdminRoleEntity> roles;

  const AdminEntity({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.roles = const [],
  });
}

class AdminRoleEntity {
  final int? id;
  final String? name;
  final String? slug;

  const AdminRoleEntity({this.id, this.name, this.slug});
}