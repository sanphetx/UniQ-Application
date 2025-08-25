import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:core/src/constants/hive_type_id.dart';

part 'token.g.dart';

@HiveType(typeId: HiveTypeId.token)
final class TokenModel extends Equatable {
  const TokenModel({
    required this.accessToken,
    this.accessTokenExpiresIn = 0,
    this.tokenType = 'Bearer',
    this.refreshToken,
  });

  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final int accessTokenExpiresIn;

  @HiveField(2)
  final String tokenType;

  @HiveField(3)
  final String? refreshToken;

  @override
  List<Object?> get props => [accessToken, accessTokenExpiresIn, tokenType, refreshToken];
}
