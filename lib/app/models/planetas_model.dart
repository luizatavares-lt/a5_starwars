import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starwars/app/models/base_model.dart';

class Planetas extends BaseModel {
  static const String COLLECTION_NAME = 'Planetas';
  static const String NOME = "nome";
  String _documentId;
  String nome;

  Planetas();

  @override
  String documentId() {
    return this._documentId;
  }

  @override
  Planetas.fromMap(DocumentSnapshot document) {
    this._documentId = document.documentID.toString();

    this.nome = document.data[Planetas.NOME];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = this.nome;

    return map;
  }
}
