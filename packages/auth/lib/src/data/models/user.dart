import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.customerId,
    this.customerName,
    this.supplierId,
    this.supplierName,
    required this.username,
    required this.role,
    this.hashedPassword,
  });

  final String? customerId;
  final String? customerName;
  final String? supplierId;
  final String? supplierName;
  final String username;
  final String role;
  final String? hashedPassword;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      supplierId: json['supplierId'] as String?,
      supplierName: json['supplierName'] as String?,
      username: json['username'] as String,
      role: json['role'] as String,
      hashedPassword: json['hashedPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'username': username,
      'role': role,
      'hashedPassword': hashedPassword,
    };
  }

  @override
  List<Object?> get props => [customerId, customerName, supplierId, supplierName, username, role, hashedPassword];
}
