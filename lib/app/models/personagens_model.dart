import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';

class Personagens extends BaseModel {
  static const String COLLECTION_NAME = 'Personagens';
  static const String NOME = "nome",
      DATA_NASCIMENTO = "data_nascimento",
      RACA_ID = "personagemraca_id",
      SEXO = "sexo";
  String _documentId;
  String nome, racaId, sexo;
  DateTime dataNascimento;

  Personagens();

  @override
  String documentId() {
    return this._documentId;
  }

  @override
  Personagens.fromMap(DocumentSnapshot document) {
    this._documentId = document.documentID.toString();

    this.nome = document.data[Personagens.NOME];
    Timestamp ts = document.data[Personagens.DATA_NASCIMENTO];
    this.dataNascimento =
        DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
    this.racaId = document.data[Personagens.RACA_ID];
    this.sexo = document.data[Personagens.SEXO];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map[Personagens.NOME] = this.nome;
    map[Personagens.DATA_NASCIMENTO] = this.dataNascimento;
    map[Personagens.RACA_ID] = this.racaId;
    map[Personagens.SEXO] = this.sexo;

    return map;
  }
}
