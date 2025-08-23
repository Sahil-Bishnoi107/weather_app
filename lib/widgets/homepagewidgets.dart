import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/Objects/Weatherobject.dart';
import 'package:weather_project/Objects/rainobject.dart';
import 'package:weather_project/database/hive.dart';
import 'package:weather_project/provider/weatherprovider.dart';
import 'package:weather_project/widgets/customWidgets.dart';
import 'package:weather_project/widgets/reusablewidgets.dart';






Widget LeftTop(double height,double width,String name,String city,String country,String time){
  return Row(
    children: [
      Container(
        width: width*0.11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 25, width: width*0.11,
              child: Text(name.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 16),)),
            Text(city.toUpperCase(), style: TextStyle(color: const Color.fromRGBO(220, 220, 220, 1),fontSize: 12),),
            Text( country.toUpperCase(),style: TextStyle(color: const Color.fromRGBO(220, 220, 220, 1),fontSize: 12),)
          ],
        ),
      ),
      SizedBox(width: 5,),
      Text(time,style: TextStyle(color: const Color.fromRGBO(225, 225, 225, 1)),)
    ],
  );
}
Widget LeftCenter(double height,double width,String weathertype,String icon,int temp){
  return Row(
    children: [
      SizedBox(width: 35,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,width: 50,
            child: SvgPicture.asset(icon,color: Colors.white,)),
            SizedBox(height: 10,),
          Text(temp.toString() + " \u00B0C", style: TextStyle(color: Colors.white,fontSize: 20),)
        ],
      ),
      SizedBox(width: 50,),
      Text(weathertype.toUpperCase(),style: TextStyle(color: const Color.fromRGBO(220, 220, 220, 1)),)
    ],
  );
}

Widget rainChances(double height,double width,List<Rain> rain){
  return Container(
    width: width*0.15,height: height*0.2,
    child: ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: rain.length < 4 ? rain.length : 4,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        return rainwidget(rain[index].time, rain[index].chance);
      }),
  ); 
}


class topbar extends StatefulWidget {
  const topbar({super.key});

  @override
  State<topbar> createState() => _topbarState();
}

class _topbarState extends State<topbar> {
  TextEditingController searchcontroller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<Weatherprovider>(
      builder: (context, value, child) =>  Container(
        alignment: Alignment.centerLeft,
        height: height*0.12,width: width*0.78,
        decoration: BoxDecoration(
        gradient: LinearGradient(colors: [ const Color.fromRGBO(40, 60, 73, 1),const Color.fromRGBO(35, 46, 58, 1),const Color.fromRGBO(11, 8, 9, 1)],
        begin: Alignment.topLeft,end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(4)         
                      ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.month ?? "AUGUST 2025",style: TextStyle(color: Colors.white),),
                Text((value.day ?? "SUNDAY" ) + ", " +  (value.month2 ?? "AUG 23")  + ", " + (value.year.toString() ?? "2025"),style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(width: 50,),
            Container(
              height: height*0.045,width: width*0.3,
              decoration: BoxDecoration(color: Colors.white,border: Border.all(),borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.search,color: const Color.fromRGBO(40, 60, 73, 1),size: 20,),
                  SizedBox(width: 5,),
                  Container(
                    width: width*0.25,
                    child:TextField(
                      
                      textAlignVertical: TextAlignVertical.top,
                      controller: searchcontroller,
                      maxLines: null,
                      style: TextStyle(fontSize: 13),
                       textInputAction: TextInputAction.done,
                    decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 0),isDense: true, ),
                    onSubmitted: (value) {
                      print(value);
                      addcity(value);
                      context.read<Weatherprovider>().getweather(searchcontroller.text);
                    },           
                    ),
                    
                  ),
                 
                ],
              ),
            ),
              Expanded(child: SizedBox()),
                  Container(
                    width: width*0.05,height: height*0.04,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Icon(Icons.notifications_none_outlined,color: const Color.fromRGBO(40, 60, 73, 1),size: 20,),
                         Icon(Icons.person_outline,color: const Color.fromRGBO(40, 60, 73, 1),size: 20,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}
Widget graph(double height,double width){
  return Column(
    children: [
      SizedBox(height: 10,),
      Scale(height, width, 40),
      Scale(height, width, 30),
      Scale(height, width, 20),
      Scale(height, width, 10),
      Scale(height, width, 0),
      Container(width: width*0.61,
        child: Row(
          children: [    
            Expanded(child: Text("w1",style: TextStyle(fontSize: 10),)),
            Expanded(child: Text("w2",style: TextStyle(fontSize: 10),)),
            Expanded(child: Text("w3",style: TextStyle(fontSize: 10),)),
             Text("w4",style: TextStyle(fontSize: 10),)
          ],
        ),
      )
    ],
  );
}
Widget curve(double height,double width,List<Offset> points){
  return Row(
    children: [
      SizedBox(width: 23,),
      CustomPaint(
            size: Size( width*0.6,height*0.1),
            painter: CurvePainter(points:points ),
          ),
    ],
  );
}








class CityTile extends StatefulWidget {
  String name;
   CityTile({super.key,required this.name});

  @override
  State<CityTile> createState() => _CityTileState();
}

class _CityTileState extends State<CityTile> {
  WeatherInfo? info;

  @override
  void initState() {
    super.initState();
    _loadinfo();
  }

  void _loadinfo() async {
    final data = await context.read<Weatherprovider>().getcityweather(widget.name);
    if (mounted) {
      setState(() {
        info = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (info == null) {
      return SizedBox(
        height: height * 0.07,
        width: width * 0.5,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height * 0.07,
      width: width * 0.5,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(40, 60, 73, 1),
            Color.fromRGBO(35, 46, 58, 1),
            Color.fromRGBO(11, 8, 9, 1)
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: width * 0.2,
            child: Text(
              "${widget.name}   ${info!.state}",
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 20),
          const Text("Temp ", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: 40,
            child: Text(
              "${info!.temprature.toInt()} °C",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 30),
          const Text("Real feel ", style: TextStyle(color: Colors.white)),
          Text(
            "${info!.apptemp.toInt()} °C",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
