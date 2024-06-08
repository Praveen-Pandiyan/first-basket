import 'dart:async';

import 'package:dio/dio.dart';
import 'package:first_basket/models/course.dart';
import 'package:flutter/foundation.dart';


class CoursesRepo extends ChangeNotifier with DiagnosticableTreeMixin {
 List<Course> list=[];
Future<void> getCourse(int offset) async {
  final dio = Dio();
  print("hello $offset");
  Response response =
      await dio.get('https://fakestoreapi.com/products?limit=${offset + 10}');
  list= (response.data as List).map((e) => Course.fromJson(e)).toList();
  notifyListeners();
}
}




