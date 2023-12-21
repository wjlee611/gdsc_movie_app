import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/signup_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/signup_state.dart';
import 'package:gdsc_movie_app/models/user/user_model.dart';
import 'package:gdsc_movie_app/repositories/firebase/user_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserModel? user;
  final UserRepository userRepository;
  final FirebaseStorage storage;

  SignupBloc({
    this.user,
    required this.userRepository,
    required this.storage,
  }) : super(SignupState(
          status: SignupStatus.init,
          user: user,
        )) {
    on<SignupChangeNameEvent>(_signupChangeNameEventHandler);
    on<SignupChangeDiscriptionEvent>(_signupChangeDiscriptionEventHandler);
    on<SignupChangeProfileImgEvent>(_signupChangeProfileImgEventHandler);
    on<SignupUploadEvent>(_signupUploadEventHandler);
  }

  Future<void> _signupChangeNameEventHandler(
    SignupChangeNameEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user?.copyWith(
        name: event.name,
      ),
    ));
  }

  Future<void> _signupChangeDiscriptionEventHandler(
    SignupChangeDiscriptionEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user?.copyWith(
        discription: event.discription,
      ),
    ));
  }

  Future<void> _signupChangeProfileImgEventHandler(
    SignupChangeProfileImgEvent event,
    Emitter<SignupState> emit,
  ) async {
    if (event.image == null) return;

    emit(state.copyWith(profileFile: File(event.image!.path)));
  }

  Future<void> _signupUploadEventHandler(
    SignupUploadEvent event,
    Emitter<SignupState> emit,
  ) async {
    // uploading image
    if (state.profileFile != null) {
      emit(state.copyWith(status: SignupStatus.uploadingImage));

      final storageRef = storage.ref().child('${state.user!.uid}/profile.jpg');
      await storageRef.putFile(state.profileFile!);

      final imageUrl = await storageRef.getDownloadURL();
      emit(state.copyWith(user: state.user?.copyWith(profile: imageUrl)));
    }

    // uploading profile
    emit(state.copyWith(status: SignupStatus.uploadingProfile));
    await userRepository.joinUser(state.user!);

    emit(state.copyWith(status: SignupStatus.success));
  }
}
