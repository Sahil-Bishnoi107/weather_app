
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/provider/mapprovider.dart';
import 'package:weather_project/provider/weatherprovider.dart';
import 'package:weather_project/screens/HomePage.dart';
import 'package:weather_project/screens/Loginpage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('UserAuth');
  await Hive.openBox('user');
  await Hive.openBox('currentMapLocation');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapProvider()),
      ChangeNotifierProvider(create: (_) => Weatherprovider())
    ],
    child: MyApp()));
}

class MyApp extends StatefulWidget{
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito'
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}