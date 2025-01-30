part of 'home_cubit.dart';

final class HomeState extends Equatable {
  final int? secretNumber;
  final int? currentNumber;
  final int attempts;
  final int difficulty;
  final List<int> greaterThan;
  final List<int> lessThan;
  final List<RecordModel> records;

  const HomeState({
    this.secretNumber,
    this.currentNumber,
    this.attempts = 5,
    this.difficulty = 0,
    this.greaterThan = const [],
    this.lessThan = const [],
    this.records = const [],
  });

  HomeState copyWith({
    int? secretNumber,
    int? currentNumber,
    int? attempts,
    int? difficulty,
    List<int>? greaterThan,
    List<int>? lessThan,
    List<RecordModel>? records,
  }) =>
      HomeState(
        secretNumber: secretNumber ?? this.secretNumber,
        currentNumber: currentNumber ?? this.currentNumber,
        attempts: attempts ?? this.attempts,
        difficulty: difficulty ?? this.difficulty,
        greaterThan: greaterThan ?? this.greaterThan,
        lessThan: lessThan ?? this.lessThan,
        records: records ?? this.records,
      );

  @override
  List<Object?> get props => [
        secretNumber,
        currentNumber,
        attempts,
        difficulty,
        greaterThan,
        lessThan,
        records,
      ];
}
