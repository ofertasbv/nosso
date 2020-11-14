import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';

class PromocaoDetalhes extends StatefulWidget {
  Promocao p;

  PromocaoDetalhes(this.p);

  @override
  _PromocaoDetalhesState createState() => _PromocaoDetalhesState();
}

class _PromocaoDetalhesState extends State<PromocaoDetalhes> {
  var selectedCard = 'WEIGHT';
  var promocaoController = GetIt.I.get<PromoCaoController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Promocao p = widget.p;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.nome),
        elevation: 0.0,
      ),
      body: buildContainer(p),
      bottomNavigationBar: buildBottomNavigationBar(context, p),
    );
  }

  buildContainer(Promocao p) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.network(
            promocaoController.arquivo + p.foto,
            fit: BoxFit.cover,
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListTile(
                  title: Text(
                    p.nome,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    p.descricao,
                  ),
                  trailing: Text(
                    "OFF ${p.desconto} %",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Código: ${p.id}"),
                SizedBox(height: 10),
                Text("Loja: ${p.loja.nome}"),
                SizedBox(height: 10),
                Text("Registro: ${dateFormat.format(p.dataInicio)}"),
                SizedBox(height: 10),
                Text("De: ${dateFormat.format(p.dataInicio)} á ${dateFormat.format(p.dataFinal)}"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildBottomNavigationBar(BuildContext context, Promocao p) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
                side: BorderSide(color: Colors.transparent),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PromocaoPage();
                    },
                  ),
                );
              },
              color: Colors.black,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.list),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("MAIS"),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
                side: BorderSide(color: Colors.transparent),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PromocaoPage();
                    },
                  ),
                );
              },
              color: Colors.orange[900],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_basket),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("MAIS OFERTAS"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
