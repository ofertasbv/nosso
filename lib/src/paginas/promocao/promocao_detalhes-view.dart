import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';

class PromocaoDetalhesView extends StatefulWidget {
  Promocao p;

  PromocaoDetalhesView(this.p);

  @override
  _PromocaoDetalhesViewState createState() => _PromocaoDetalhesViewState();
}

class _PromocaoDetalhesViewState extends State<PromocaoDetalhesView> {
  var selectedCard = 'WEIGHT';
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Promocao p = widget.p;

    return buildContainer(p);
  }

  buildContainer(Promocao p) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            promocaoController.arquivo + p.foto,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                trailing: Chip(
                  label: Text(
                    "OFF ${formatMoeda.format(p.desconto)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
