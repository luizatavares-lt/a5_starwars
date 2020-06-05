import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:starwars/app/modules/logon/logon_bloc.dart';
import 'package:starwars/app/app_module.dart';

void main() {
  initModule(AppModule());
  LogonBloc bloc;

  // setUp(() {
  //     bloc = AppModule.to.bloc<LogonBloc>();
  // });

  // group('LogonBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<LogonBloc>());
  //   });
  // });
}
