import 'package:nosso/src/core/model/pageable.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/sort.dart';

class ProdutoData {
  List<Produto> produto;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  bool first;
  Sort sort;
  int size;
  int number;
  int numberOfElements;
  bool empty;

  ProdutoData(
      {this.produto,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.first,
      this.sort,
      this.size,
      this.number,
      this.numberOfElements,
      this.empty});

  ProdutoData.fromJson(Map<String, dynamic> json) {
    if (json['produto'] != null) {
      produto = new List<Produto>();
      json['produto'].forEach((v) {
        produto.add(new Produto.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    first = json['first'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    size = json['size'];
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produto != null) {
      data['produto'] = this.produto.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['first'] = this.first;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['size'] = this.size;
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}