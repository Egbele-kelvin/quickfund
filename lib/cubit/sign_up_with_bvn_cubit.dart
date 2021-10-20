import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_with_bvn_state.dart';

class SignUpWithBvnCubit extends Cubit<SignUpWithBvnState> {
  SignUpWithBvnCubit() : super(SignUpWithBvnInitial());
}
