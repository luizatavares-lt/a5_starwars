import 'package:flutter/material.dart';
import 'package:starwars/app/models/personagens_raca_model.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_bloc.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_edit_page.dart';
import 'package:starwars/app/utils/main_drawer.dart';

class PersonagensRacaPage extends StatefulWidget {
  final String title;
  static const String route = '/personagensRaca';

  const PersonagensRacaPage({Key key, this.title = "Raça dos Personagens"}) : super(key: key);

  @override
  _PersonagensRacaPageState createState() => _PersonagensRacaPageState();
}

class _PersonagensRacaPageState extends State<PersonagensRacaPage> {
  var _bloc = PersonagensRacaBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          var _personagensRaca = PersonagensRaca()..nome = "";

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonagensRacaEditPage(_personagensRaca),
            ),
          );
        },
      ),
      body: Container(
        child: StreamBuilder<List<PersonagensRaca>>(
          stream: _bloc.getPersonagensRaca,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return Container(
              child: ListView(
                children: snapshot.data.map(
                  (_personagensRaca) {
                    return Dismissible(
                      key: Key(_personagensRaca.documentId()),
                      onDismissed: (direction) {
                        _bloc.delete(_personagensRaca.documentId());
                      },
                      child: ListTile(
                        title: Text(_personagensRaca.nome),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonagensRacaEditPage(_personagensRaca),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
