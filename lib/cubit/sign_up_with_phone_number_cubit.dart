import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_with_phone_number_state.dart';

class SignUpWithPhoneNumberCubit extends Cubit<SignUpWithPhoneNumberState> {
  SignUpWithPhoneNumberCubit() : super(SignUpWithPhoneNumberInitial());
}
