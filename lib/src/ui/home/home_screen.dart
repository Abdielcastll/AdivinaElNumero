import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
import 'widgets/widgets.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: MyAppBar(),
        body: _BodyHome(),
      ),
    );
  }
}

class _BodyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputWidget(),
                const SizedBox(height: 15),
                AttemptCounter()
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardNumber(
                      title: "Mayor que",
                      numbers: state.greaterThan,
                    ),
                    CardNumber(
                      title: "Menor que",
                      numbers: state.lessThan,
                    ),
                    CardNumber(
                      title: "Historial",
                      records: state.records,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            Difficulty()
          ],
        ),
      ),
    );
  }
}
