import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/Conometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Cronometro()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    valor: store.tempoTrabalho,
                    titulo: "Trabalho",
                    inc: store.incrementarTempoTrabalho,
                    dec: store.decrementarTempoTrabalho,
                    cor: store.estaTrabalhando() ? Colors.red : Colors.green,
                  ),
                  EntradaTempo(
                    valor: store.tempoDescanso,
                    titulo: "Descanso",
                    inc: store.incrementarTempoDescanso,
                    dec: store.decrementarTempoDescanso,
                    cor: store.estaTrabalhando() ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
