import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/Objects/rainobject.dart';
import 'package:weather_project/apis/register.dart';
import 'package:weather_project/provider/weatherprovider.dart';
import 'package:weather_project/screens/map.dart';
import 'package:weather_project/widgets/homepagewidgets.dart';
import 'package:weather_project/widgets/reusablewidgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currpage = 1;
  List<Rain> ourrainlist = [];
  List<Rain> subrain = [];
  final box = Hive.box('user');
  void changePage(int val){setState(() {
    currpage = val;
  });}
  @override
  void initState() {
    final city = box.get('city') ?? "Delhi";
    // TODO: implement initState
    super.initState();
   ourrainlist = [
    Rain(chance: 12, time: "00:00"),Rain(chance: 15, time: "01:00"),Rain(chance: 20, time: "02:00"),
    Rain(chance: 22, time: "03:00"),Rain(chance: 50, time: "04:00"),Rain(chance: 61, time: "05:00"),
    Rain(chance: 43, time: "06:00"),Rain(chance: 26, time: "07:00"),Rain(chance: 78, time: "08:00"),
    Rain(chance: 90, time: "09:00"),Rain(chance: 32, time: "10:00"),Rain(chance: 11, time: "11:00"),
    Rain(chance: 17, time: "12:00"),Rain(chance: 62, time: "13:00"),Rain(chance: 66, time: "14:00"),
    Rain(chance: 87, time: "15:00"),Rain(chance: 100, time: "16:00"),Rain(chance: 44, time: "17:00"),
    Rain(chance: 19, time: "18:00"),Rain(chance: 0, time: "19:00"),Rain(chance: 12, time: "20:00"),
    Rain(chance: 14, time: "21:00"),Rain(chance: 07, time: "22:00"),Rain(chance: 24, time: "23:00"),
    ];
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<Weatherprovider>().getweather(city);
  });
    
    
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wf = width*0.03;double hf = height*0.00675;
    List<Offset> points = [
    Offset(0,172- 21*hf),Offset(wf*1,172- 20*hf),Offset(wf*2,172- 22*hf),Offset(wf*3,172- 24*hf),Offset(wf*4,172- 28*hf),Offset(wf*5,172- 27*hf),Offset(wf*6,172- 30*hf),
    Offset(wf*7,172- 24*hf),Offset(wf*8,172- 25*hf),Offset(wf*9,172- 27*hf),Offset(wf*10,172- 28*hf),Offset(wf*11,172- 27*hf),Offset(wf*12,172- 24*hf),Offset(wf*13,172- 28*hf),
    Offset(wf*14,172- 20*hf),Offset(wf*15,172- 22*hf),Offset(wf*16,172- 24*hf),Offset(wf*17,172- 28*hf),Offset(wf*18,172- 27*hf),Offset(wf*19,172- 25*hf),Offset(wf*20,172- 28*hf)
  ];
  
 
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 255, 255, 1),
      body: Container(
        
        height: height,width: width,
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            final name = box.get('name') ?? "User";
            
            return  Consumer<Weatherprovider>(
            builder: (context, value, child) =>  
            Column(
              children: [
                Container(
                  height: height*0.1,width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: width*0.28,),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        child: Container(
                          height: height*0.045,width: width*0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             // SizedBox(width: 20,),
                              InkWell(
                                onTap: () => changePage(1),
                                child: MenuOption(height, width,currpage, Icons.dashboard, 'DASHBOARD', 15,1)),        
                              InkWell(
                                onTap: () => changePage(2),
                                child: MenuOption(height, width, currpage, Icons.bookmark_add_sharp, 'SAVED LOCATION', 15, 2)),
                              InkWell(
                                onTap: () => changePage(3),
                                child: MenuOption(height, width, currpage, Icons.map, 'MAP', 15, 3)),
                              InkWell(
                                onTap: () => changePage(4),
                                child: MenuOption(height, width, currpage, Icons.calendar_month_outlined, 'CALENDER', 15, 4)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: width*0.29,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ExtraOption(height, width, Icons.settings_outlined, 'SETTINGS', 15),
                            SizedBox(height: 5,),
                            ExtraOption(height, width, Icons.logout_outlined, 'LOG OUT', 15)
                          ],
                        )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
            
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [ const Color.fromRGBO(40, 60, 73, 1),const Color.fromRGBO(35, 46, 58, 1),const Color.fromRGBO(11, 8, 9, 1)],
                        begin: Alignment.topLeft,end: Alignment.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      height: height*0.85,width: width*0.18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.03,),
                        LeftTop(height, width, name, value.a ?? "Unknown", value.state ?? "Unknown" , value.weatherData?.time ?? "00:00"),
                        SizedBox(height: 50,),
                        LeftCenter(height, width, 'Sunny', 'assets/svgs/reshot-icon-weather-X3N7PHUCLR.svg', (value.weatherData?.temprature ?? 0 ).toInt() ),
                        SizedBox(height: 40,),
                        Text('CHANCES OF RAIN',style: TextStyle(color: Colors.white,fontSize: 12),),
                        SizedBox(height: 20,),
                        rainChances(height, width,ourrainlist ),
                        Text("SUNRISE AND SUNSET",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 12),),
                        SizedBox(height: 10,),
                        sunrise(height, width, 'assets/svgs/sun-svgrepo-com.svg', 'SUNRISE', "06:07", ' IN 5 hours'),
                        sunrise(height, width, 'assets/svgs/sun-fog-svgrepo-com.svg', 'SUNSET', '19:22', '7 hours ago')
                      ],
                    ),
                    ),
                    SizedBox(width: 20,),
                    currentstate(height, width, points, value,currpage)
                    
                  ],
                ),
              ]
            ),
          );},
        ),
      ),
    );
  }
}



Widget currentstate(double height,double width,List<Offset> points,Weatherprovider value,int x){
  if(x == 1){return   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topbar(),
                        SizedBox(height: 40,),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("TODAYS OVERVIEW",style: TextStyle(color: const Color.fromRGBO(40, 60, 73, 1),fontSize: 18),)),
                          SizedBox(height: 20,),
                          Row(children: [
                            SizedBox(width: 50,),
                            infobox(height, width,'assets/svgs/wind-svgrepo-com.svg', "WIND SPEED", (value.weatherData?.wind.toInt() ?? 0) as int, "KM/H",20),
                            SizedBox(width: 20,),
                            infobox(height, width, 'assets/svgs/drop-svgrepo-com (1).svg', "RAIN", (value.weatherData?.rainchance.toInt() ?? 0) as int, "%",20),
                          ],),
                          SizedBox(height: 20,),
                          Row(children: [
                            SizedBox(width: 50,),
                            infobox(height, width,'assets/svgs/pressure-svgrepo-com.svg', "REAL FEEL", (value.weatherData?.apptemp.toInt() ?? 30) as int, "\u00B0C",22),
                            SizedBox(width: 20,),
                            infobox(height, width, 'assets/svgs/sun-svgrepo-com.svg', "UV INDEX", 6, "",25),
                          ],),
                          SizedBox(height: 30,),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("AVERAGE WEEKLY TEMPRATURE",style: TextStyle(color: const Color.fromRGBO(40, 60, 73, 1),fontSize: 18))),
            
            
                            Container(
                              height: height*0.27,width: width*0.7,
                              child: Row(
                                children: [
                                  SizedBox(width: 40,),
                                  Stack(
                                    children: [
                                    graph(height, width),
                                    curve(height, width, points)
                                    ],
                                  )
                                ],
                              ),
                            )
                      ],
                    );}

        if(x == 2){
          final box = Hive.box('user');
          List<String> cities = box.containsKey('cities') ? box.get('cities') : [];

          return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) => 
             Container(
              height: height*0.7,width: width*0.6,
               child: ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: cities.length,
                itemBuilder: (context,index){
               
                  return CityTile(name: cities[index]);
                }),
             ),
          );
        }
        if(x==3){
          return MapWidget();
        }
        else{
          return Placeholder();
        }            
  
}

