import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_in_progress_state.dart';

class DashboardInProgressCubit extends Cubit<DashboardInProgressState> {
  DashboardInProgressCubit() : super(DashboardInProgressInitial());
}
