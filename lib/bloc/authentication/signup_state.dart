import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:gdsc_movie_app/models/user/user_model.dart';

enum SignupStatus {
  init,
  uploadingImage,
  uploadingProfile,
  success,
  fail,
}

class SignupState extends Equatable {
  final SignupStatus status;
  final UserModel? user;
  final File? profileFile;
  final double? percent;

  const SignupState({
    required this.status,
    this.user,
    this.profileFile,
    this.percent,
  });

  SignupState copyWith({
    SignupStatus? status,
    UserModel? user,
    File? profileFile,
    double? percent,
  }) =>
      SignupState(
        status: status ?? this.status,
        user: user ?? this.user,
        profileFile: profileFile ?? this.profileFile,
        percent: percent ?? this.percent,
      );

  @override
  List<Object?> get props => [
        status,
        user,
        profileFile,
        percent,
      ];
}
