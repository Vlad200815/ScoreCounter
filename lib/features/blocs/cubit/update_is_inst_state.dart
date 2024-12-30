part of 'update_is_inst_cubit.dart';

abstract class UpdateIsInstState extends Equatable {
  const UpdateIsInstState();

  @override
  List<Object> get props => [];
}

final class UpdateIsInstInitial extends UpdateIsInstState {
  const UpdateIsInstInitial({required this.value});

  final bool value;

  @override
  List<Object> get props => [value];
}
