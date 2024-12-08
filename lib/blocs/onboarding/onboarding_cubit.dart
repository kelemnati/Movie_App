import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  final int totalPages;

  OnboardingCubit(this.totalPages) : super(0);

  void setPage(int pageIndex) {
    emit(pageIndex);
  }

  void nextPage() {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  bool get isLastPage => state == totalPages - 1;
}
