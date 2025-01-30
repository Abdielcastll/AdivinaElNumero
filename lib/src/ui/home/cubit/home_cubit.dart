import 'dart:math';

import 'package:adivina_el_numero/src/core/model/record_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _setSecretNumber();
  }

  void calculateNumber(int currentNumber) {
    if (currentNumber == state.secretNumber) {
      _restart(state.secretNumber!, success: true);
    } else if (state.attempts <= 1) {
      _restart(state.secretNumber!, success: false);
    } else if (currentNumber < state.secretNumber!) {
      _greaterThan(currentNumber);
    } else if (currentNumber > state.secretNumber!) {
      _lessThan(currentNumber);
    }
  }

  void _setSecretNumber() {
    emit(state.copyWith(secretNumber: _generateSecretNumber(0)));
  }

  void _restart(int currentNumber, {required bool success}) {
    emit(state.copyWith(
      attempts: _attemptsByDifficulty(state.difficulty),
      secretNumber: _generateSecretNumber(state.difficulty),
      lessThan: List.empty(),
      greaterThan: List.empty(),
      records: <RecordModel>[
        ...state.records,
        RecordModel(
          number: currentNumber,
          success: success,
        )
      ],
    ));
  }

  void _lessThan(int currentNumber) {
    emit(state.copyWith(
      attempts: state.attempts - 1,
      lessThan: <int>[...state.lessThan, currentNumber],
    ));
  }

  void _greaterThan(int currentNumber) {
    emit(state.copyWith(
      attempts: state.attempts - 1,
      greaterThan: <int>[...state.greaterThan, currentNumber],
    ));
  }

  void changeDifficulty(int i) {
    emit(state.copyWith(
      difficulty: i,
      secretNumber: _generateSecretNumber(i),
      attempts: _attemptsByDifficulty(i),
      greaterThan: [],
      lessThan: [],
    ));
  }

  int _attemptsByDifficulty(int difficulty) {
    switch (difficulty) {
      case 0: // fácil
        return 5;
      case 1: // Medio
        return 8;
      case 2: // Avanzado
        return 15;
      case 3: // Extremo
        return 25;
      default:
        return 5;
    }
  }

  int _generateSecretNumber(int difficulty) {
    final Random random = Random();

    switch (difficulty) {
      case 0:
        return random.nextInt(10) + 1; // 1 - 10
      case 1:
        return random.nextInt(20) + 1; // 1 - 20
      case 2:
        return random.nextInt(100) + 1; // 1 - 100
      case 3:
        return random.nextInt(1000) + 1; // 1 - 1000
      default:
        return random.nextInt(10) + 1; // 1 - 10
    }
  }
}
