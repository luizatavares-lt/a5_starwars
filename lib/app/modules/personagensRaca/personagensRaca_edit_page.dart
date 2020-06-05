import 'package:flutter/material.dart';
import 'package:starwars/app/models/personagens_raca_model.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_bloc.dart';

class PersonagensRacaEditPage extends StatefulWidget {
  final PersonagensRaca personagensRaca;

  PersonagensRacaEditPage(this.personagensRaca);

  @override
  State<StatefulWidget> createState() => _PersonagensRacaEditPageState();
}

class _PersonagensRacaEditPageState extends State<PersonagensRacaEditPage> {
  TextEditingController _nomeController;
  final _bloc = PersonagensRacaBloc();

  @override
  void initState() {
    _bloc.setPersonagensRaca(widget.personagensRaca);
    _nomeController = TextEditingController(text: widget.personagensRaca.nome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Editar Raça'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nome da Raça",
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
