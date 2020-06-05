import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_bloc.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_repository.dart';

class PersonagensRacaModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PersonagensRacaBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PersonagensRacaRepository()),
      ];

  @override
  Widget get view => Container();

  static Inject get to => Inject<PersonagensRacaModule>.of();
}
