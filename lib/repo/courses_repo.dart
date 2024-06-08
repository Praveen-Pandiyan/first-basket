import 'dart:async';

import 'package:dio/dio.dart';
import 'package:first_basket/models/course.dart';
import 'package:flutter/foundation.dart';

final dio = Dio();

class CoursesRepo extends ChangeNotifier with DiagnosticableTreeMixin {
  List<Course> list = [];
  List<Course>? searchList;
  Future<void> getCourse(int offset) async {
    print("hello $offset");
    Response response =
        await dio.get('https://fakestoreapi.com/products?limit=${offset + 10}');
    list = (response.data as List).map((e) => Course.fromJson(e)).toList();
    notifyListeners();
  }

  resetSearch() {
    searchList = null;
    notifyListeners();
  }

  search(String q) async {
    searchList = list.where((e) => e.title!.toLowerCase().contains(q)).toList();
    notifyListeners();
  }
}
