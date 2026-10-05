import 'package:hf_customer_app/models/enum/role_enum.dart';

class Accounts {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final Roles role;

  final String? phoneNumber;
  final bool isActive;
  final bool? isEmailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSignInAt;

  Accounts({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.lastSignInAt,
    this.phoneNumber,
    this.isEmailVerified,
  });

  factory Accounts.fromJson(Map<String, dynamic> json) {
    return Accounts(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      role: json['role'] as Roles,
      phoneNumber: json['phone_number'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'] as String)
          : null,
      isActive: json['is_active'] as bool? ?? true,
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
    );
  }
}
