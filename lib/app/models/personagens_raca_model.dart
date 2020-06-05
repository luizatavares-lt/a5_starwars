import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starwars/app/models/base_model.dart';

class PersonagensRaca extends BaseModel {
  static const String COLLECTION_NAME = 'PersonagensRaca';
  static const String NOME = "nome";
  String _documentId;
  String nome;

  PersonagensRaca();

  @override
  String documentId() {
    return this._documentId;
  }

  @override
  PersonagensRaca.fromMap(DocumentSnapshot document) {
    this._documentId = document.documentID.toString();

    this.nome = document.data[PersonagensRaca.NOME];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = this.nome;

    return map;
  }
}
