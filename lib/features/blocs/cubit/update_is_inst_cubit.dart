import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_is_inst_state.dart';

class UpdateIsInstCubit extends Cubit<UpdateIsInstState> {
  UpdateIsInstCubit() : super(UpdateIsInstInitial(value: false));

  void updateBool(bool newBool) {
    emit(UpdateIsInstInitial(value: newBool));
  }
}
