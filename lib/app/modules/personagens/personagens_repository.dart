import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:starwars/app/models/personagens_model.dart';
import 'package:rxdart/rxdart.dart';

class PersonagensRepository extends Disposable {
  CollectionReference _collection =
      Firestore.instance.collection(Personagens.COLLECTION_NAME);

  void add(Personagens _personagens) => _collection.add(_personagens.toMap());

  void update(String _documentId, Personagens _personagens) =>
      _collection.document(_documentId).updateData(_personagens.toMap());

  void delete(String _documentId) => _collection.document(_documentId).delete();

  Observable<List<Personagens>> get getAll =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<Personagens>((document) => Personagens.fromMap(document))
          .toList()));

  Future<Personagens> getById(String _documentId) async {
    DocumentSnapshot _pets = await _collection.document(_documentId).get();

    return Personagens.fromMap(_pets);
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
