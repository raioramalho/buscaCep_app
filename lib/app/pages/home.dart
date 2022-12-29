import 'package:flutter/material.dart';
import 'package:tasklist_app/main.dart';
import '../components/buildTextfield.dart';
import '../components/buildText.dart';

// ignore: camel_case_types
class addr {
  addr({required String c, t, n, e, u, b, la, ln, ci, ib, dd}) {
    cep = c;
    tipo = t;
    nome = n;
    end = e;
    uf = u;
    bairro = b;
    lat = la;
    lng = ln;
    cidade = ci;
    ibge = ib;
    ddd = dd;
  }
  String? cep, tipo, nome, end, uf, bairro, lat, lng, cidade, ibge, ddd;
}

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
                  // ignore: non_constant_identifier_names
                  addr End = addr(
                      c: snapshot.data?['cep'],
                      t: snapshot.data?['address_type'],
                      n: snapshot.data?['address_name'],
                      e: snapshot.data?['address'],
                      u: snapshot.data?['state'],
                      b: snapshot.data?['district'],
                      la: snapshot.data?['lat'],
                      ln: snapshot.data?['lng'],
                      ci: snapshot.data?['city'],
                      ib: snapshot.data?['city_ibge'],
                      dd: snapshot.data?['ddd']);

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
                        buildText(' CEP: ${End.cep}'),
                        buildText(' CIDADE: ${End.cidade}  UF: ${End.uf}'),
                        buildText(' ENDEREÇO: ${End.end} - ${End.bairro}'),
                        buildText(' DDD: ${End.ddd}'),
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
