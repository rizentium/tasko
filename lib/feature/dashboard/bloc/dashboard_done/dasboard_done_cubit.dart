import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dasboard_done_state.dart';

class DasboardDoneCubit extends Cubit<DasboardDoneState> {
  DasboardDoneCubit() : super(DasboardDoneInitial());
}
