import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class Difficulty extends StatefulWidget {
  const Difficulty({
    super.key,
  });

  @override
  State<Difficulty> createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
  double _sliderValue = 0;

  final List<String> options = ["Fácil", "Medio", "Avanzado", "Extremo"];
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Column(
      children: [
        Text(
          options[_sliderValue.toInt()],
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: _sliderValue,
          min: 0,
          max: 3,
          divisions: 3,
          onChanged: (value) {
            setState(() {
              _sliderValue = value.roundToDouble();
              cubit.changeDifficulty(value.toInt());
            });
          },
          allowedInteraction: SliderInteraction.tapAndSlide,
        )
      ],
    );
  }
}
