import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/signup_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/signup_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/signup_state.dart';
import 'package:gdsc_movie_app/constants/gaps.dart';
import 'package:gdsc_movie_app/constants/sizes.dart';
import 'package:gdsc_movie_app/widgets/common_input_widget.dart';
import 'package:gdsc_movie_app/widgets/common_loading_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  SignupScreen({super.key});

  void _onTapAvatar(BuildContext context) async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      context.read<SignupBloc>().add(SignupChangeProfileImgEvent(image: image));
    } catch (_) {
      // TODO: 지원하지 않는 형식입니다.
    }
  }

  void _onNameChanged(
    BuildContext context,
    String? name,
  ) {
    context.read<SignupBloc>().add(SignupChangeNameEvent(name: name));
  }

  void _onDiscriptionChanged(
    BuildContext context,
    String? discription,
  ) {
    context
        .read<SignupBloc>()
        .add(SignupChangeDiscriptionEvent(discription: discription));
  }

  void _onSave(BuildContext context) {
    context.read<SignupBloc>().add(SignupUploadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          context.read<AuthBloc>().add(AuthInitEvent());
          context.pop();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              title: const Text('회원가입'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Column(
                children: [
                  Gaps.v16,
                  Row(
                    children: [
                      BlocBuilder<SignupBloc, SignupState>(
                        buildWhen: (previous, current) =>
                            previous.profileFile != current.profileFile,
                        builder: (context, state) => GestureDetector(
                          onTap: () => _onTapAvatar(context),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade500,
                            radius: Sizes.size60,
                            backgroundImage: state.profileFile == null
                                ? null
                                : Image.file(state.profileFile!).image,
                          ),
                        ),
                      ),
                      Gaps.h16,
                      const Text(
                        '프로필 이미지\n선택',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        Sizes.size10,
                      ),
                    ),
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) => CommonInputWidget(
                        viewSuffix: false,
                        hintText: '닉네임',
                        value: state.user?.name,
                        onChange: (name) => _onNameChanged(
                          context,
                          name,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v20,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        Sizes.size10,
                      ),
                    ),
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) => CommonInputWidget(
                        viewSuffix: false,
                        hintText: '한 줄 소개',
                        onChange: (discription) => _onDiscriptionChanged(
                          context,
                          discription,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: GestureDetector(
              onTap: () => _onSave(context),
              child: Container(
                color: Colors.yellow.shade700,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.size10,
                    bottom:
                        MediaQuery.of(context).padding.bottom + Sizes.size10,
                  ),
                  child: const Text(
                    '저장',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              if (state.status == SignupStatus.uploadingImage ||
                  state.status == SignupStatus.uploadingImage) {
                return Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const CommonLoadingWidget(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
