class AuthLoginModel {
  final bool? success;
  final String? message;
  final AuthLoginData? data;

  AuthLoginModel({this.success, this.message, this.data});

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) => AuthLoginModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? AuthLoginData.fromJson(json['data']) : null,
      );
}

class AuthLoginData {
  final AdminUserModel? user;
  final String? token;
  final String? tokenType;

  AuthLoginData({this.user, this.token, this.tokenType});

  factory AuthLoginData.fromJson(Map<String, dynamic> json) => AuthLoginData(
        user: json['user'] != null ? AdminUserModel.fromJson(json['user']) : null,
        token: json['token'],
        tokenType: json['token_type'],
      );
}

class AdminMeModel {
  final bool? success;
  final AdminUserModel? data;

  AdminMeModel({this.success, this.data});

  factory AdminMeModel.fromJson(Map<String, dynamic> json) => AdminMeModel(
        success: json['success'],
        data: json['data'] != null ? AdminUserModel.fromJson(json['data']) : null,
      );
}

class AdminUserModel {
  final int? id;
  final String? uuid;
  final String? name;
  final String? email;
  final String? phone;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final List<AdminRoleModel> roles;

  AdminUserModel({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.roles = const [],
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) => AdminUserModel(
        id: json['id'],
        uuid: json['uuid'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        roles: json['roles'] != null
            ? List.from(json['roles']).map((e) => AdminRoleModel.fromJson(e)).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'name': name,
        'email': email,
        'phone': phone,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'roles': roles.map((e) => e.toJson()).toList(),
      };
}

class AdminRoleModel {
  final int? id;
  final String? name;
  final String? slug;

  AdminRoleModel({this.id, this.name, this.slug});

  factory AdminRoleModel.fromJson(Map<String, dynamic> json) => AdminRoleModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'slug': slug};
}