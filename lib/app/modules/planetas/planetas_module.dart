import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:starwars/app/modules/planetas/planetas_bloc.dart';
import 'package:starwars/app/modules/planetas/planetas_repository.dart';

class PlanetasModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => PlanetasBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PlanetasRepository()),
      ];

  @override
  Widget get view => Container();

  static Inject get to => Inject<PlanetasModule>.of();
}
