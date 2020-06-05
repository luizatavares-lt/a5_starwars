import 'package:starwars/app/modules/personagens/personagens_repository.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class PersonagensModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PersonagensRacaBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PersonagensRepository()),
      ];

  @override
  Widget get view => Container();

  static Inject get to => Inject<PersonagensModule>.of();
}
