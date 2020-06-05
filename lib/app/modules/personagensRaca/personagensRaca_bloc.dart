import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:starwars/app/app_module.dart';
import 'package:starwars/app/models/personagens_raca_model.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonagensRacaBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PersonagensRacaRepository>();
  String _documentId;
  String _nome;

  PersonagensRacaBloc() {
    _nomeController.listen((value) => _nome = value);
  }

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outNome => _nomeController.stream;
  void setNome(String value) => _nomeController.sink.add(value);

  Observable<List<PersonagensRaca>> get getPersonagensRaca => _repository.getAll;

  void delete(String _documentId) => _repository.delete(_documentId);

  void setPersonagensRaca(PersonagensRaca personagensRaca) {
    _documentId = personagensRaca.documentId();
    setNome(personagensRaca.nome);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool insertOrUpdate() {
    var _personagens = PersonagensRaca()..nome = _nome;

    if (_documentId?.isEmpty ?? true) {
      _repository.add(_personagens);
    } else {
      _repository.update(_documentId, _personagens);
    }

    return true;
  }
}
