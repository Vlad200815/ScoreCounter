import 'package:bloc/bloc.dart';

class UpdateBoolCubit extends Cubit<bool> {
  UpdateBoolCubit() : super(false);

  void updateBool(bool newValue) {
    emit(newValue);
  }
}
