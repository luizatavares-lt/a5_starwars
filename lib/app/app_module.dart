import 'package:starwars/app/modules/logon/logon_bloc.dart';
import 'package:starwars/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:starwars/app/app_widget.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_repository.dart';
import 'package:starwars/app/modules/planetas/planetas_repository.dart';

import 'modules/personagens/personagens_repository.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LogonBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PersonagensRacaRepository()),
        Dependency((i) => PersonagensRepository()),
        Dependency((i) => PlanetasRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
