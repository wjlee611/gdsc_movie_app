import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? uid;
  final String? email;
  final String? profile;
  final String? name;
  final String? discription;

  const UserModel({
    this.uid,
    this.email,
    this.profile,
    this.name,
    this.discription,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? profile,
    String? name,
    String? discription,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        profile: profile ?? this.profile,
        name: name ?? this.name,
        discription: discription ?? this.discription,
      );

  factory UserModel.fronJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        uid,
        email,
        profile,
        name,
        discription,
      ];
}
