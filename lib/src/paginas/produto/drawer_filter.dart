import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/paginas/categoria/categoria_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/util/config/config_page.dart';
import 'package:nosso/src/util/sobre/sobre_page.dart';

class DrawerFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          builderBodyBack(),
          menuLateral(context),
        ],
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[100],
            Colors.grey[100],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  ListView menuLateral(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          color: Colors.amber,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Icon(
                  Icons.add_box_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                maxRadius: 15,
                backgroundColor: Colors.yellow[600],
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Opções de pesquisa"),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("categoria"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomePage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("marca"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            showSearch(
              context: context,
              delegate: ProdutoSearchDelegate(),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("preço"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("produto"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("oferta"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_box_outlined),
          title: Text("loja"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
