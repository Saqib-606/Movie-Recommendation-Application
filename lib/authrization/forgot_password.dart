import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/authrization/login.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State <ForgotPassword> createState () => _ForgotPasswordState();
}

class _ForgotPasswordState extends State <ForgotPassword> {
  TextEditingController email = TextEditingController();
  GlobalKey <FormState> formkey = GlobalKey <FormState> ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              "assets/images/The Odyssey.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 700,
            )
          ),

          Expanded(
            flex: 8,
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)
                  )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                                
                      SizedBox(height: 25,),
                      
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 5,),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "No worries! Enter your email and we'll send you a link to reset your password.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      SizedBox(height: 25,),
                      
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.email, color: Colors.grey,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey
                                  )
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2
                                  )
                                )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Email";
                                }
                                return null;
                              },
                            ),  
                          ],
                        ),
                      ),

                      SizedBox(height: 25,),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Consumer<AuthrizationProvider>(
                          builder: (context, provider, child) {
                            return provider.loading ? Center(child: CircularProgressIndicator(),) :
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  bool success = await provider.forgotPassword(email.text);
                                  if (success) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(10)
                                )
                              ),
                              child: Text(
                                "Send Reset Link",
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            );
                          },
                        )
                      ),

                      SizedBox(height: 25,),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary
                              ),
                            ),
                          ),
                      
                          Expanded(
                            child: Divider(
                              color: AppColors.textSecondary
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 25,),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 15),
                            iconAlignment: IconAlignment.start,
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1
                            ),
                            backgroundColor: AppColors.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            )
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Colors.amberAccent,
                                ),
                              ),

                              Text(
                                "Back to Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}