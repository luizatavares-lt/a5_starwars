import 'package:flutter/material.dart';
import 'package:starwars/app/models/planetas_model.dart';
import 'package:starwars/app/modules/planetas/planetas_bloc.dart';

class PlanetasEditPage extends StatefulWidget {
  final Planetas planetas;

  PlanetasEditPage(this.planetas);

  @override
  State<StatefulWidget> createState() => _PlanetasEditPageState();
}

class _PlanetasEditPageState extends State<PlanetasEditPage> {
  TextEditingController _nomeController;
  final _bloc = PlanetasBloc();

  @override
  void initState() {
    _bloc.setPlanetas(widget.planetas);
    _nomeController = TextEditingController(text: widget.planetas.nome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Editar Planeta'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nome do Planeta",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black87)),                  controller: _nomeController,
                  onChanged: _bloc.setNome,
                ),
              ),
              RaisedButton(
                child: Text("Salvar"),
                onPressed: () {
                  if (_bloc.insertOrUpdate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
