import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/authrization/login.dart';
import 'package:movie_recommendation_app/authrization/sign_up.dart';
import 'package:movie_recommendation_app/home/home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Image.asset(
                "assets/images/The Odyssey.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
      
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsetsGeometry.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                        },
                        child: Text("Login", style: TextStyle(color: Colors.black87),),
                      ),
                    ),
                      
                    SizedBox(height: 15,),
                      
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade900
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                        },
                        child: Text("Sign Up", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                      
                    SizedBox(height: 10,),
                      
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) => Home(),
                        ),(value) => false);
                      },
                      child: Text("Guest User", style: TextStyle(color: Colors.yellow,),),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}