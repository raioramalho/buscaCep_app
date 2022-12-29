import 'package:flutter/material.dart';
import 'package:tasklist_app/main.dart';
import '../components/buildTextfield.dart';
import '../components/buildText.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final cepController = TextEditingController();

  void _cepChanged(String text) {
    String search = text;
    cepController.text = search;
    print(text);
    _reloadMap();
  }

  Future<void> _reloadMap() async {
    setState(() {
      getData(cepController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Busca Cep"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _reloadMap,
        child: FutureBuilder<Map>(
          future: getData(cepController.text),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando....',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao carregar dados',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var getCep = snapshot.data?['cep'];
                  var getCidade = snapshot.data?['city'];
                  var getEndereco = snapshot.data?['address_type'];
                  var getInfo = snapshot.data?['address_name'];
                  var getLocal = snapshot.data?['district'];
                  var getDdd = snapshot.data?['ddd'];
                  var getUf = snapshot.data?['state'];

                  var getLat = snapshot.data?['lat'];
                  var getLng = snapshot.data?['lng'];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Icon(
                          Icons.location_history,
                          size: 50,
                          color: Colors.deepPurple,
                        ),
                        buildTextField(
                            'Busca Cep:', 'CEP: ', cepController, _cepChanged),
                        const Divider(),
                        buildText(' CEP: $getCep'),
                        buildText(' CIDADE: $getCidade - UF: $getUf'),
                        buildText(
                            ' ENDEREÇO: $getEndereco - $getInfo - $getLocal'),
                        buildText(' DDD: $getDdd'),
                        const Divider(),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _reloadMap();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.map_outlined,
        ),
      ),
    );
  }
}
