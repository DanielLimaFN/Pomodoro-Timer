import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo {TRABALHO, DESCANSO}


abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;



  Timer? cronometro;


  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(Duration(seconds: 1), (timer) {
      if(minutos == 0 && segundos == 0){
        _tocarTipoIntervalo();
      } else if(segundos == 0){
        segundos = 59;
        minutos--;
      }else {
        segundos--;
      }

    });
  }

  @action
  void parar() {
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempoTrabalho() {
    if(tempoTrabalho == 99){
      return;
    }
    tempoTrabalho++;
    if(estaTrabalhando()){
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    if(tempoTrabalho == 1){
      return;
    }
    tempoTrabalho--;
    if(estaTrabalhando()){
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    if(tempoDescanso == 99){
      return;
    }

    tempoDescanso++;
    if(estaDescansado()){
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    if(tempoDescanso == 1){
      return;
    }
    tempoDescanso--;
    if(estaDescansado()){
      reiniciar();
    }
  }

  bool estaTrabalhando(){
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }
  bool estaDescansado(){
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void _tocarTipoIntervalo(){
    if(estaTrabalhando()){
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    }else{
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
