import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:starwars/app/app_module.dart';
import 'package:starwars/app/models/planetas_model.dart';
import 'package:starwars/app/modules/planetas/planetas_repository.dart';
import 'package:rxdart/rxdart.dart';

class PlanetasBloc extends BlocBase {
  var _repository = AppModule.to.getDependency<PlanetasRepository>();
  String _documentId;
  String _nome;

  PlanetasBloc() {
    _nomeController.listen((value) => _nome = value);
  }

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outNome => _nomeController.stream;
  void setNome(String value) => _nomeController.sink.add(value);

  Observable<List<Planetas>> get getPlanetas => _repository.getAll;

  void delete(String _documentId) => _repository.delete(_documentId);

  void setPlanetas(Planetas planetas) {
    _documentId = planetas.documentId();
    setNome(planetas.nome);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool insertOrUpdate() {
    var _planetas = Planetas()..nome = _nome;

    if (_documentId?.isEmpty ?? true) {
      _repository.add(_planetas);
    } else {
      _repository.update(_documentId, _planetas);
    }

    return true;
  }
}
