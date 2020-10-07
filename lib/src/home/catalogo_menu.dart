import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/paginas/loja/loja_location.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/barcodigo/leitor_codigo_barra.dart';
import 'package:nosso/src/util/barcodigo/leitor_qr_code.dart';

class CatalogoMenu extends StatefulWidget {
  @override
  _CatalogoMenuState createState() => _CatalogoMenuState();
}

class _CatalogoMenuState extends State<CatalogoMenu> {
  PageController _pageController;
  int _page = 0;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("u-nosso app"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProdutoSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: new Icon(
              Icons.home,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return HomePage();
                }),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(1),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.transparent,
                  height: 140,
                  child: CategoriaListHome(),
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(0),
                  ),
                  height: 350,
                  child: buildGridView(context),
                ),
                SizedBox(height: 4),
                Container(
                  height: 130,
                  child: ProdutoListHome(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _builderBodyBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[200],
              Colors.grey[200],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );

  GridView buildGridView(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 2),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,

      //childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.9,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorQRCode();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.bar_chart,
                  size: 30,
                ),
                padding: EdgeInsets.all(20),
              ),
              Text(
                "QR code",
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
                padding: EdgeInsets.all(20),
              ),
              Text(
                "Cod de barra",
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaLocation();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.map,
                  size: 30,
                ),
                padding: EdgeInsets.all(20),
              ),
              Text(
                "Locais",
              ),
            ],
          ),
        ),
      ],
    );
  }
}