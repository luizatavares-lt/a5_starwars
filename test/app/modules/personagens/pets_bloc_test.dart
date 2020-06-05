import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:starwars/app/modules/personagens/personagens_bloc.dart';
import 'package:starwars/app/modules/personagens/personagens_module.dart';

void main() {
  initModule(PersonagensModule());
  PersonagensBloc bloc;

  // setUp(() {
  //     bloc = PetsModule.to.bloc<PetsBloc>();
  // });

  // group('PetsBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<PetsBloc>());
  //   });
  // });
}
