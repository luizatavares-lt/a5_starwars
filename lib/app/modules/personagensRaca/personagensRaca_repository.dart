import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:starwars/app/models/personagens_raca_model.dart';
import 'package:rxdart/rxdart.dart';

class PersonagensRacaRepository extends Disposable {
  CollectionReference _collection =
      Firestore.instance.collection(PersonagensRaca.COLLECTION_NAME);

  void add(PersonagensRaca _personagensRaca) => _collection.add(_personagensRaca.toMap());

  void update(String _documentId, PersonagensRaca _personagensRaca) =>
      _collection.document(_documentId).updateData(_personagensRaca.toMap());

  void delete(String _documentId) => _collection.document(_documentId).delete();

  Observable<List<PersonagensRaca>> get getAll =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<PersonagensRaca>((document) => PersonagensRaca.fromMap(document))
          .toList()));

  Future<PersonagensRaca> getById(String _documentId) async {
    DocumentSnapshot personagensRaca = await _collection.document(_documentId).get();

    return PersonagensRaca.fromMap(personagensRaca);
  }

  Future fetchPost(Dio client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
