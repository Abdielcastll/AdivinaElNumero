import 'package:adivina_el_numero/src/core/model/record_model.dart';
import 'package:flutter/material.dart';

class CardNumber extends StatelessWidget {
  final String title;
  final List<RecordModel>? records;
  final List<int>? numbers;

  const CardNumber({super.key, required this.title, this.records, this.numbers})
      : assert(
          (records != null) ^ (numbers != null),
          'Debe proporcionar solo una de las listas, no ambas ni ninguna.',
        );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .28,
      height: size.height * .50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (numbers != null)
              ...numbers!.map(
                (e) => Text(
                  e.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            if (records != null)
              ...records!.map(
                (e) => Text(
                  e.number.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: e.success ? Colors.green[800] : Colors.red[800]),
                ),
              )
          ],
        ),
      ),
    );
  }
}
