import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Afazeres'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tarefas[index].descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editarTarefa(index); // Chama a função para editar a tarefa
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _excluirTarefa(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controlador,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.resolveWith<Size>(
                        (Set<MaterialState> states) {
                          return const Size(200, 60);
                        },
                      ),
                    ),
                    child: const Text('Adicionar Tarefa'),
                    onPressed: () {
                      if (_controlador.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        _tarefas.add(
                          Tarefa(
                            descricao: _controlador.text,
                            status: false,
                          ),
                        );
                        _controlador.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editarTarefa(int index) {
    TextEditingController _controladorEdicao =
        TextEditingController(text: _tarefas[index].descricao);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: TextField(
            controller: _controladorEdicao,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tarefas[index].descricao = _controladorEdicao.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
