import 'package:adivina_el_numero/src/ui/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttemptCounter extends StatelessWidget {
  const AttemptCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Text(
            "Intentos\n${state.attempts}",
            style: TextStyle(height: 1.5, fontSize: 16),
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}
