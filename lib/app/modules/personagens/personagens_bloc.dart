import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:starwars/app/models/personagens_model.dart';
import 'package:starwars/app/modules/personagens/personagens_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../app_module.dart';

class PersonagensBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PersonagensRepository>();
  String _documentId;
  String _nome, _racaId, _sexo;
  DateTime _dataNascimento;

  PersonagensBloc() {
    _nomeController.listen((value) => _nome = value);
    _racaIdController.listen((value) => _racaId = value);
    _sexoController.listen((value) => _sexo = value);
    _dataNascimentoController.listen((value) => _dataNascimento = value);
  }

  // Nome
  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outNome => _nomeController.stream;
  void setNome(String value) => _nomeController.sink.add(value);

  // PetTiposId
  var _racaIdController = BehaviorSubject<String>();
  Stream<String> get outRacaId => _racaIdController.stream;
  String get outRacaIdValue => _racaIdController.stream.value;
  void setRacaId(String value) => _racaIdController.sink.add(value);

  // Sexo
  var _sexoController = BehaviorSubject<String>();
  Stream<String> get outSexo => _sexoController.stream;
  String get outSexoValue => _sexoController.stream.value;
  void setSexo(String value) => _sexoController.sink.add(value);

  // DataNascimento
  var _dataNascimentoController = BehaviorSubject<DateTime>();
  Stream<DateTime> get outDataNascimento => _dataNascimentoController.stream;
  void setDataNascimento(DateTime value) =>
      _dataNascimentoController.sink.add(value);

  Observable<List<Personagens>> get getPersonagens => _repository.getAll;

  void delete(String _documentId) => _repository.delete(_documentId);

  void setPersonagens(Personagens pets) {
    _documentId = pets.documentId();
    setNome(pets.nome);
    setDataNascimento(pets.dataNascimento);
    setRacaId(pets.racaId);
    setSexo(pets.sexo);
  }

  bool insertOrUpdate() {
    var _pets = Personagens()
      ..nome = _nome
      ..racaId = _racaId
      ..sexo = _sexo
      ..dataNascimento = _dataNascimento;

    if (_documentId?.isEmpty ?? true) {
      _repository.add(_pets);
    } else {
      _repository.update(_documentId, _pets);
    }

    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
