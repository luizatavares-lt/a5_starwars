import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starwars/app/models/personagens_model.dart';
import 'package:starwars/app/modules/personagens/personagens_bloc.dart';
import 'package:starwars/app/modules/personagens/personagens_edit_page.dart';
import 'package:starwars/app/utils/main_drawer.dart';

class PersonagensPage extends StatefulWidget {
  final String title;
  static const String route = '/personagens';

  const PersonagensPage({Key key, this.title = "Personagens"}) : super(key: key);

  @override
  _PersonagensPageState createState() => _PersonagensPageState();
}

class _PersonagensPageState extends State<PersonagensPage> {
  var _bloc = PersonagensBloc();

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
          var _personagens = Personagens()
            ..nome = ""
            ..racaId = ""
            ..sexo = ""
            ..dataNascimento = DateTime.now();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonagensEditPage(_personagens),
            ),
          );
        },
      ),
      body: Container(
        child: StreamBuilder<List<Personagens>>(
          stream: _bloc.getPersonagens,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return Container(
              child: ListView(
                children: snapshot.data.map(
                  (_personagens) {
                    return Dismissible(
                      key: Key(_personagens.documentId()),
                      onDismissed: (direction) {
                        _bloc.delete(_personagens.documentId());
                      },
                      child: ListTile(
                        title: Text(_personagens.nome),
                        subtitle: Text(new DateFormat("dd/MM/yyyy")
                            .format(_personagens.dataNascimento)),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonagensEditPage(_personagens),
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
