import 'package:hive_flutter/hive_flutter.dart';

void addcity(String city){
  final box = Hive.box('user');
  List<String> citylist = box.containsKey('cities') ?  box.get('cities') : [];
  citylist.add(city);
  box.put('cities', citylist);
}