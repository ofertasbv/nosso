import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constant_api.dart';
import 'package:nosso/src/api/custon_dio.dart';
import 'package:nosso/src/core/model/promocao.dart';

class PromocaoRepository {
  CustonDio dio = CustonDio();

  Future<List<Promocao>> getAll() async {
    try {
      print("carregando promoções");
      var response = await dio.client.get("/promocoes");
      // print("${response.data}");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getAllById(int id) async {
    try {
      print("carregando promoções by id");
      var response = await dio.client.get("/promocoes/${id}");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    try {
      var response = await dio.client.post("/promocoes/create", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    try {
      var response = await dio.client.put("/promocoes/update/$id", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response =
      await dio.client.delete("/promocoes/delete/foto/$foto");
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<FormData> upload(File file, String fileName) async {
    var arquivo = file.path;

    var paramentros = {
      "foto": await MultipartFile.fromFile(arquivo, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);
    dio.client.post(ConstantApi.urlList + "/promocoes/upload", data: formData);

    print("RESPONSE: $dio");
    print("fileDir: ${file.path}");
    return formData;
  }
}
