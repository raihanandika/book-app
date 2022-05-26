import 'package:book_app/models/book_detail_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:book_app/models/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookListResponse;

  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookListResponse = BookListResponse.fromJson(jsonBookList);
    }

    notifyListeners();

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  BookDetailResponse? detailResponse;

  fetchDetailBookApi(String? isbn) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailResponse = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();

      fetchSimiliarBookApi(detailResponse!.title);
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  BookListResponse? similiarBooks;

  fetchSimiliarBookApi(String? title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(url);
    // debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }
}
