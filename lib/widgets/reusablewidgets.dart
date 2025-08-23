import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget MenuOption(double height,double width,int selected,IconData icon,String text,double size,int index){
  Color color  = selected != index ? Colors.blueGrey : Colors.black;
  return Row(
    children: [
      Icon(icon,color: color,size: size,),
      SizedBox(width: 5,),
      Text(text,style: TextStyle(fontSize: 11,color: color),)
    ],
  );
}
Widget ExtraOption(double height,double width,IconData icon,String text,double size){
  Color color  =    Colors.black;
  return Material(
    color: Colors.white,
    elevation: 1,
    borderRadius: BorderRadius.circular(4),
    child: Container(
      alignment: Alignment.center,
    //  padding: EdgeInsets.all(2),
    height: height*0.04,width: width*0.07,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: color,size: size,),
            SizedBox(width: 5,),
            Text(text,style: TextStyle(fontSize: 11,color: color),)
          ],
        ),
      ),
    ),
  );
}

Widget rainwidget(String time,int rainchance){
  
  return Row(
    children: [
    Text(time,style: TextStyle(color: const Color.fromRGBO(220, 220, 220, 1),fontSize: 12,fontWeight: FontWeight.w300),),
    Container(width: 100,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: const Color.fromRGBO(60, 88, 128, 1),borderRadius: BorderRadius.circular(5)),
          width: 85,height: 7,
          ),
        Container(
          height: 7,
          decoration: BoxDecoration(color: const Color.fromRGBO(150, 175, 200, 1),borderRadius: BorderRadius.circular(5)),
          width: rainchance.toDouble()*0.85,)
      ],
    ),
    ),
    Text(rainchance.toString() + " %",style: TextStyle(color: const Color.fromRGBO(220, 220, 220, 1),fontSize: 12,fontWeight: FontWeight.w300),)
    ],
  );
}

Widget sunrise(double height,double width,String icon,String sunrise,String time,String timeleft){
  return Container(
    height: height*0.07,width: width*0.16,
    child: Row(
     
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: SvgPicture.asset(icon,color: const Color.fromRGBO(215, 215, 215, 1),)),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(sunrise,style: TextStyle(color: const Color.fromRGBO(215, 215, 215, 1),fontSize: 12),),
              Text(time,style: TextStyle(color: const Color.fromRGBO(215, 215, 215, 1),fontSize: 12),)
            ],
          ),
          SizedBox(width: 20,),
          Text(timeleft ,style: TextStyle(color: const Color.fromRGBO(215, 215, 215, 1),fontSize: 12),)
      ],
    ),
  );
}

Widget infobox(double height,double width,String icon,String title,int data,String unit,double size){
  return Container(
    height: height*0.11,width: width*0.14,
   // padding: EdgeInsets.only(left: 40),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      gradient: LinearGradient(colors: [ const Color.fromRGBO(40, 60, 73, 1),const Color.fromRGBO(35, 46, 58, 1),const Color.fromRGBO(11, 8, 9, 1)],
      
      )
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20,),
        Container(
          height: size,width: size,
          child: SvgPicture.asset(icon,color: const Color.fromRGBO(215, 215, 215, 1),)),
          SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(title,style: TextStyle(color: const Color.fromRGBO(215, 215, 215, 1),fontSize: 12),),
              Text(data.toString() + " " + unit,style: TextStyle(color: const Color.fromRGBO(215, 215, 215, 1),fontSize: 14),)
          ],
        )
      ],
    ),
  );
}

Widget Scale(double height,double width,int num){
  return Row(
    children: [
      Container(
        width: 14,
        child: Text(num.toString(),style: TextStyle(fontSize: 10,),)),
      SizedBox(width: 10,),
      Container(
        margin: EdgeInsets.symmetric(vertical: 14),
        color: const Color.fromRGBO(210, 210, 210, 1),
        height: 1,width: width*0.6,)
    ],
  );
}
Widget loginoption(double height,double width,TextEditingController txt,String text,IconData icon,String hint){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
    //  mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontWeight: FontWeight.w400),),
        SizedBox(width: 5,),
        Container(
          height: 33,width: width*0.25,
          padding: EdgeInsets.only(bottom: 12,left: 6),
          decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(180, 178, 178, 1)),borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: txt,
            decoration: InputDecoration(border: InputBorder.none,
            hintText: hint,hintStyle: TextStyle(fontSize: 14,color: const Color.fromRGBO(180, 178, 178, 1))
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
       
      ],
    ),
  );
}

Widget button(double height,double width,String text,bool type){
  Color txtcolor = type ? Colors.white : Colors.black;
  Color bg = type ? Colors.black : Colors.white;
  Color border =  Colors.black ;
   return Container(
    height: 33,width: width*0.25,
    decoration: BoxDecoration(border: Border.all(color: border),color: bg,borderRadius: BorderRadius.circular(5)),
    child: Center(
      child: Text(text,style: TextStyle(color: txtcolor),),
    ),
   );
}