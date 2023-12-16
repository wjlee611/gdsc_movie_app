import 'package:image_picker/image_picker.dart';

class SignupEvent {}

class SignupChangeNameEvent extends SignupEvent {
  String? name;

  SignupChangeNameEvent({this.name});
}

class SignupChangeDiscriptionEvent extends SignupEvent {
  String? discription;

  SignupChangeDiscriptionEvent({this.discription});
}

class SignupChangeProfileImgEvent extends SignupEvent {
  XFile? image;

  SignupChangeProfileImgEvent({this.image});
}

class SignupUploadEvent extends SignupEvent {}
