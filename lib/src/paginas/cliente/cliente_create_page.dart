import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';
import 'package:nosso/src/api/constant_api.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/core/repository/cliente_repository.dart';
import 'package:nosso/src/paginas/cliente/cliente_page.dart';

class ClienteCreatePage extends StatefulWidget {
  Cliente cliente;

  ClienteCreatePage({Key key, this.cliente}) : super(key: key);

  @override
  _ClienteCreatePageState createState() =>
      _ClienteCreatePageState(p: this.cliente);
}

class _ClienteCreatePageState extends State<ClienteCreatePage> {
  ClienteController clienteController = GetIt.I.get<ClienteController>();
  Cliente p;
  Endereco e;
  Usuario u;

  _ClienteCreatePageState({this.p});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime dataAtual = DateTime.now();
  String _valor;
  String valorSlecionado;
  File file;

  @override
  void initState() {
    if (p == null) {
      p = Cliente();
      u = Usuario();
      e = Endereco();
    } else {
      u = p.usuario;
      e = p.endereco;
    }

    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

  enableButton() {
    setState(() {
      isEnabledEnviar = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabledDelete = true;
    });
  }

  onClickFoto() async {
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);
    var atual = DateTime.now();
    setState(() {
      this.file = f;
      String arquivo = file.path.split('/').last;
      String filePath = arquivo.replaceAll(
          "$arquivo", "cliente-" + atual.toString() + ".png");
      print("arquivo: $arquivo");
      print("filePath: $filePath");
      p.foto = filePath;
    });
  }

  onClickUpload() async {
    if (file != null) {
      var url = await ClienteRepository.upload(file, p.foto);
      print(" URL : $url");
      disableButton();
    }
  }

  showDefaultSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Icon(Icons.photo_album),
        action: SnackBarAction(
          label: content,
          onPressed: () {
            enableButton();
            onClickFoto();
          },
        ),
      ),
    );
  }

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.indigo,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo),
              trailing: Icon(Icons.arrow_forward),
              title: Text("ir para galeria"),
              onTap: () {
                onClickFoto();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    var maskFormatterCelular = new MaskTextInputFormatter(
        mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')});

    var maskFormatterCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

    p.endereco = e;
    p.usuario = u;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de cliente"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_upload,
            ),
            onPressed: onClickFoto,
          )
        ],
      ),
      body: Observer(
        builder: (context) {
          if (clienteController.error != null) {
            return Text("Não foi possível cadastrar cliente");
          } else {
            return ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  child: Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Text("Dados Pessoais"),
                                SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    RadioListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text("PESSOA FISICA"),
                                      value: "FISICA",
                                      groupValue: p.tipoPessoa,
                                      onChanged: (String valor) {
                                        setState(() {
                                          p.tipoPessoa = valor;
                                          print("resultado: " + p.tipoPessoa);
                                          showDefaultSnackbar(context,
                                              "Pessoa: ${p.tipoPessoa}");
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text("PESSOA JURIDICA"),
                                      value: "JURIDICA",
                                      groupValue: p.tipoPessoa,
                                      onChanged: (String valor) {
                                        setState(() {
                                          p.tipoPessoa = valor;
                                          print("resultado: " + p.tipoPessoa);
                                          showDefaultSnackbar(context,
                                              "Pessoa: ${p.tipoPessoa}");
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  initialValue: p.nome,
                                  onSaved: (value) => p.nome = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    hintText: "nome",
                                    prefixIcon: Icon(Icons.people),
                                    suffixIcon: Icon(Icons.close),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.cpf,
                                  onSaved: (value) => p.cpf = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "cpf",
                                    hintText: "cpf",
                                    prefixIcon: Icon(Icons.contact_mail),
                                    suffixIcon: Icon(Icons.close),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  inputFormatters: [maskFormatterCPF],
                                  keyboardType: TextInputType.number,
                                  maxLength: 14,
                                ),
                                TextFormField(
                                  initialValue: p.telefone,
                                  onSaved: (value) => p.telefone = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Telefone",
                                    hintText: "Telefone celular",
                                    prefixIcon: Icon(Icons.phone),
                                    suffixIcon: Icon(Icons.close),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [maskFormatterCelular],
                                ),
                                SizedBox(height: 0),
                                DateTimeField(
                                  initialValue: p.dataRegistro,
                                  format: dateFormat,
                                  validator: (value) =>
                                      value == null ? "campo obrigário" : null,
                                  onSaved: (value) => p.dataRegistro = value,
                                  decoration: InputDecoration(
                                    labelText: "data registro",
                                    hintText: "99-09-9999",
                                    prefixIcon: Icon(
                                      Icons.calendar_today
                                    ),
                                    suffixIcon: Icon(Icons.close),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      locale: Locale('pt', 'BR'),
                                      lastDate: DateTime(2030),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  initialValue: p.usuario.email,
                                  onSaved: (value) => p.usuario.email = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    suffixIcon: Icon(Icons.close),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: p.usuario.senha,
                                  onSaved: (value) => p.usuario.senha = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Senha",
                                    hintText: "Senha",
                                    prefixIcon: Icon(Icons.security),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        clienteController.visualizarSenha();
                                      },
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: !clienteController.senhaVisivel,
                                  maxLength: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 0),
                        Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    RaisedButton(
                                      child: Icon(Icons.delete_forever),
                                      shape: new CircleBorder(),
                                      onPressed: isEnabledDelete
                                          ? () => clienteController
                                              .deleteFoto(p.foto)
                                          : null,
                                    ),
                                    RaisedButton(
                                      child: Icon(Icons.photo),
                                      shape: new CircleBorder(),
                                      onPressed: () {
                                        showDefaultSnackbar(
                                            context, "ir para galeria");
                                      },
                                    ),
                                    RaisedButton(
                                      child: Icon(Icons.check),
                                      shape: new CircleBorder(),
                                      onPressed: isEnabledEnviar
                                          ? () => onClickUpload()
                                          : null,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.grey[300],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    file != null
                                        ? Image.file(
                                            file,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : p.foto != null
                                            ? Image.network(
                                                ConstantApi.urlArquivoLoja +
                                                    p.foto,
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Text("anexar arquivo"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 0),
                        Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  initialValue: p.endereco.logradouro,
                                  onSaved: (value) =>
                                      p.endereco.logradouro = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Logradouro",
                                    hintText: "Logradouro",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.complemento,
                                  onSaved: (value) =>
                                      p.endereco.complemento = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Complemento",
                                    hintText: "Complemento",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.tipoEndereco,
                                  onSaved: (value) =>
                                      p.endereco.tipoEndereco = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "TipoEndereço",
                                    hintText: "TipoEndereço",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.numero,
                                  onSaved: (value) => p.endereco.numero = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Número",
                                    hintText: "Número",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.cep,
                                  onSaved: (value) => p.endereco.cep = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Cep",
                                    hintText: "Cep",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    MaskedTextInputFormatter(
                                        mask: '99999-999', separator: '-')
                                  ],
                                  maxLength: 9,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.bairro,
                                  onSaved: (value) => p.endereco.bairro = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Bairro",
                                    hintText: "Bairro",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.latitude.toString(),
                                  onSaved: (value) => e.latitude = double.tryParse(value),
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Latitude",
                                    hintText: "Latidute",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  maxLength: 50,
                                ),
                                TextFormField(
                                  initialValue: p.endereco.longitude.toString(),
                                  onSaved: (value) => e.longitude = double.tryParse(value),
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Longitude",
                                    hintText: "Longitude",
                                    prefixIcon: Icon(Icons.location_on),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  maxLength: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    label: Text(
                      "Enviar formulário",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.black,
                    onPressed: () {
                      if (controller.validate()) {
                        if (p.foto == null) {
                          showToast("deve anexar uma foto!");
                        } else {
                          onClickUpload();
                          clienteController.create(p);

                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ClientePage();
                              },
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
