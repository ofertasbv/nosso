import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/model/produto.dart';

class ProdutoDetalhesInfo extends StatefulWidget {
  Produto p;

  ProdutoDetalhesInfo(this.p);

  @override
  _ProdutoDetalhesInfoState createState() => _ProdutoDetalhesInfoState();
}

class _ProdutoDetalhesInfoState extends State<ProdutoDetalhesInfo> {
  Produto p;

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return buildContainer(p);
  }

  buildContainer(Produto p) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ListView(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text("Produto"),
                        subtitle: Text("${p.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Descrição"),
                        subtitle: Text("${p.descricao}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Data Registro"),
                        subtitle: Text("${dateFormat.format(p.dataRegistro)}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Valor"),
                        subtitle: Text("R\$ ${p.estoque.valor}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Desconto"),
                        subtitle: Text("R\$ ${p.desconto}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Quantidade"),
                        subtitle: Text("${p.estoque.quantidade}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Código de barra"),
                        subtitle: Text("${p.codigoBarra}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("SKU"),
                        subtitle: Text("${p.sku}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Novo"),
                        subtitle: Text("${p.novo}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Status"),
                        subtitle: Text("${p.status}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Favorito"),
                        subtitle: Text("${p.favorito}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Medida"),
                        subtitle: Text("${p.medida}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Tamanho"),
                        subtitle: Text("${p.tamanho}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Origem"),
                        subtitle: Text("${p.origem}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Marca"),
                        subtitle: Text("${p.marca.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Categoria"),
                        subtitle: Text("${p.subCategoria.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Promoção"),
                        subtitle: Text("${p.promocao.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Loja"),
                        subtitle: Text("${p.loja.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                    ],
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
