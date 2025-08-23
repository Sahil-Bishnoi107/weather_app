import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_project/apis/register.dart';
import 'package:weather_project/screens/HomePage.dart';
import 'package:weather_project/widgets/reusablewidgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController usernameReg = TextEditingController();
  TextEditingController passwordReg = TextEditingController();
  TextEditingController city = TextEditingController();
  bool loginactive = true;
  bool registered = false;
  void _register(){
    setState(() {
      loginactive = !loginactive;
    });
  }
  void _registered(){
    setState(() {
      registered = !registered;
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: const Color.fromRGBO(245, 255, 255, 1),
      body: Container(
        height: height,width: width,
        child: Center(
          child: Container(
            width: width*0.8,height: height*0.65,
            child: Material(
              color: Colors.white,
              elevation: 2,
              child: Row(
                children: [
                  Container(
                    width: width*0.45,height: height*0.65,
                    child: Image.asset("assets/images/rosalind-chang-Z4dSigcFgVw-unsplash.jpg",fit: BoxFit.cover,)),
                  Container(
                    width: width*0.35,height: height*0.65,
                    child: loginactive ? 
                    Column(
                    children: [
                      SizedBox(height: height*0.05,
                      ),
                      Text("LOGIN TO CONTINUE",style: TextStyle(fontSize: 20),),
                      SizedBox(height: height*0.07,),
                    loginoption(height, width, username, 'Username', Icons.person_pin,"Enter your Username"),
                    loginoption(height, width, password, 'Password', Icons.lock,"Enter your Password"),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: ()async {
                        bool b = await login(username.text, password.text);
                        if(b) Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                      },
                      child: button(height, width, "LOGIN", true)),
                    SizedBox(height: 10,),
                    Text("OR"),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () => _register(),
                      child: button(height, width, "REGISTER", false))
                    ],
                  ) : !registered ?
                     Column(
                    children: [
                      SizedBox(height: height*0.05,
                      ),
                      Text("CREATE A NEW ACCOUNT",style: TextStyle(fontSize: 20),),
                      SizedBox(height: height*0.03,),
                    loginoption(height, width, username, 'Username', Icons.person_pin,"Enter your Username"),
                    loginoption(height, width, password, 'Password', Icons.lock,"Enter your Password"),
                    loginoption(height, width, city, 'City', Icons.location_on_sharp,"Enter your City Name"),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: () async {
                       bool b = await  register(username.text, city.text, password.text);
                       if(b){_registered();}
                      },
                      child: button(height, width, "REGISTER", true)),
                      SizedBox(height: 10,),
                      Text('OR'),
                      SizedBox(height: 10,),
                      InkWell(
                      onTap: () async {
                      _register();
                      
                      },
                      child: button(height, width, "LOGIN", false))
                    ],
                  ) : 
                  Column(

              children: [
                SizedBox(height: 30,),
                Lottie.asset("assets/animations/Success Check.json",
                height: 220,width: 220,
                animate: true,
                repeat: false  
                ),
                SizedBox(height: 10,),
                Text("REGISTRATION SUCCESSFUL!",style: TextStyle(color: Colors.black,fontSize: 20),),
                SizedBox(height: 30,),
                InkWell(
                  onTap: () => _register(),
                  child: button(height, width, "LOGIN", false))
          
              ],
            )
               ) ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

