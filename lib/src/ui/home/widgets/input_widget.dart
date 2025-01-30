import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Expanded(child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            maxLength: _maxLength(state.difficulty),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onFieldSubmitted: (v) {
              if (_validator(value: v, difficulty: state.difficulty) == null) {
                cubit.calculateNumber(int.parse(v));
                _controller.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  _snackBar(v, state),
                );
              }
            },
            decoration: InputDecoration(
              counter: SizedBox.shrink(),
              border: OutlineInputBorder(),
              hintText: _hinText(state.difficulty),
              label: Text("Números"),
              errorText: null,
            ),
          ),
        );
      },
    ));
  }

  SnackBar _snackBar(String v, HomeState state) {
    return SnackBar(
      content: Center(
        child: Text(
          _validator(value: v, difficulty: state.difficulty) ?? "",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _hinText(int i) {
    switch (i) {
      case 0:
        return "##";
      case 1:
        return "##";
      case 2:
        return "###";
      case 3:
        return "####";
      default:
        return "##";
    }
  }

  int _maxLength(int i) {
    switch (i) {
      case 0:
        return 2;
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 4;
      default:
        return 2;
    }
  }

  String? _validator({required String? value, required int difficulty}) {
    if (value == null || value.isEmpty) return "Introduce un número válido";
    final valueInt = int.tryParse(value);
    if (valueInt == null) return "Introduce un número válido";

    switch (difficulty) {
      case 0:
        if (valueInt < 1 || valueInt > 10) {
          return "Ingresa un número del 1 al 10";
        }
        break;
      case 1:
        if (valueInt < 1 || valueInt > 20) {
          return "Ingresa un número del 1 al 20";
        }
        break;
      case 2:
        if (valueInt < 1 || valueInt > 100) {
          return "Ingresa un número del 1 al 100";
        }
        break;
      case 3:
        if (valueInt < 1 || valueInt > 1000) {
          return "Ingresa un número del 1 al 1000";
        }
        break;
    }
    return null; // No hay error
  }
}
