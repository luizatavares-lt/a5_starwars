import 'package:flutter/material.dart';
import 'package:starwars/app/models/planetas_model.dart';
import 'package:starwars/app/modules/planetas/planetas_bloc.dart';
import 'package:starwars/app/modules/planetas/planetas_edit_page.dart';
import 'package:starwars/app/utils/main_drawer.dart';

class PlanetasPage extends StatefulWidget {
  final String title;
  static const String route = '/planetas';

  const PlanetasPage({Key key, this.title = "Planetas"}) : super(key: key);

  @override
  _PlanetasPageState createState() => _PlanetasPageState();
}

class _PlanetasPageState extends State<PlanetasPage> {
  var _bloc = PlanetasBloc();

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
          var _planetas = Planetas()..nome = "";

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanetasEditPage(_planetas),
            ),
          );
        },
      ),
      body: Container(
        child: StreamBuilder<List<Planetas>>(
          stream: _bloc.getPlanetas,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return Container(
              child: ListView(
                children: snapshot.data.map(
                  (_planetas) {
                    return Dismissible(
                      key: Key(_planetas.documentId()),
                      onDismissed: (direction) {
                        _bloc.delete(_planetas.documentId());
                      },
                      child: ListTile(
                        title: Text(_planetas.nome),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanetasEditPage(_planetas),
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
