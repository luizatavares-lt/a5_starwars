import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starwars/app/models/planetas_model.dart';

class PlanetasRepository extends Disposable {
  CollectionReference _collection =
      Firestore.instance.collection(Planetas.COLLECTION_NAME);

  void add(Planetas _planetas) => _collection.add(_planetas.toMap());

  void update(String _documentId, Planetas _planetas) =>
      _collection.document(_documentId).updateData(_planetas.toMap());

  void delete(String _documentId) => _collection.document(_documentId).delete();

  Observable<List<Planetas>> get getAll =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<Planetas>((document) => Planetas.fromMap(document))
          .toList()));

  Future<Planetas> getById(String _documentId) async {
    DocumentSnapshot planetas = await _collection.document(_documentId).get();

    return Planetas.fromMap(planetas);
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
