import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starwars/app/models/personagens_model.dart';
import 'package:starwars/app/models/personagens_raca_model.dart';
import 'package:starwars/app/modules/personagens/personagens_bloc.dart';
import 'package:starwars/app/modules/personagensRaca/personagensRaca_bloc.dart';

class PersonagensEditPage extends StatefulWidget {
  final Personagens personagens;

  PersonagensEditPage(this.personagens);

  @override
  State<StatefulWidget> createState() => _PersonagensEditPageState();
}

class _PersonagensEditPageState extends State<PersonagensEditPage> {
  TextEditingController _nomeController;
  final _bloc = PersonagensBloc();
  final _blocPersonagensRaca = PersonagensRacaBloc();
  final _dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    _bloc.setPersonagens(widget.personagens);
    _nomeController = TextEditingController(text: widget.personagens.nome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
          appBar: AppBar(
            title: Text('Edição Personagens'),
            backgroundColor: Colors.deepPurple,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Nome do Personagem",
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black87)),
                      controller: _nomeController,
                      onChanged: _bloc.setNome,

                    ),
                  ),
                  Container(height: 20),
                  StreamBuilder<DateTime>(
                    stream: _bloc.outDataNascimento,
                    initialData: DateTime.now(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return InkWell(
                        onTap: () => _inputDataNascimento(context, snapshot.data),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Data de Nascimento",
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.black87)),
                          child: Row(
                            children: <Widget>[
                              Text(_dateFormat.format(snapshot.data)),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(height: 20),
                  Container(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Raça do Personagem",
                      ),
                      child: StreamBuilder<List<PersonagensRaca>>(
                          stream: _blocPersonagensRaca.getPersonagensRaca,
                          builder: (context, snapshotPersonagensRaca) {
                            var _personagensRacaId = _bloc.outRacaIdValue == null ||
                                    _bloc.outRacaIdValue == ""
                                ? snapshotPersonagensRaca.data.first.documentId()
                                : _bloc.outRacaIdValue;

                            if (!snapshotPersonagensRaca.hasData)
                              return CircularProgressIndicator();

                            return DropdownButton<String>(
                              value: _personagensRacaId,
                              isExpanded: true,
                              items:
                                  snapshotPersonagensRaca.data.map((PersonagensRaca _personagensRaca) {
                                return DropdownMenuItem<String>(
                                  value: _personagensRaca.documentId(),
                                  child: Text(_personagensRaca.nome),
                                );
                              }).toList(),
                              onChanged: (String racaId) {
                                setState(() {
                                  _personagensRacaId = racaId;
                                  _bloc.setRacaId(racaId);
                                });
                              },
                            );
                          }),
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Sexo",
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text("Masculino"),
                            leading: Radio(
                              value: "M",
                              groupValue: _bloc.outSexoValue,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.setSexo(value);
                                });
                              },
                              activeColor: Colors.deepPurple,
                            ),
                          ),
                          ListTile(
                            title: const Text("Feminino"),
                            leading: Radio(
                              value: "F",
                              groupValue: _bloc.outSexoValue,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.setSexo(value);
                                });
                              },
                              activeColor: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
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

  Future _inputDataNascimento(
      BuildContext context, DateTime initialDate) async {
    final DateTime choosedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2113));

    if (choosedDate != null) {
      _bloc.setDataNascimento(choosedDate);
    }
  }
}
