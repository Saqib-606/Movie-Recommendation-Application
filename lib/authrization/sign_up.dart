import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/provider/BackgroundImageProvider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/authrization/login.dart';
import 'package:movie_recommendation_app/home/home.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State <SignUp> createState () => _SignUpScreenState();
}

class _SignUpScreenState extends State <SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey <FormState> formkey = GlobalKey <FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Consumer<Backgroundimageprovider>(
              builder: (context, provider, child) {
                if (provider.backgroundImages.isEmpty) {
                  return Image.asset(
                    "assets/images/The Odyssey.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: CachedNetworkImage(
                    imageUrl: provider.backgroundImages[provider.currentIndex],
                    key: ValueKey(
                      provider.backgroundImages[provider.currentIndex],
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amberAccent,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        "assets/images/The Odyssey.jpg",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                );
              }
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
              
                      SizedBox(height: 15,),
              
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
              
                      Text(
                        "Join now and explore the best movies",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary
                        ),
                      ),
                      
                      
                      SizedBox(height: 15,),
                      
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: name,
                              style: TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.person, color: Colors.grey,),
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
                                  return "Please Enter Name";
                                }
                                return null;
                              },
                            ),
              
                            SizedBox(height: 10,),
              
                            TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                hintText: "Email",
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
                                          
                            SizedBox(height: 10,),
                                          
                            TextFormField(
                              controller: password,
                              style: TextStyle(color: Colors.grey),
                              obscureText: !isPasswordVisible,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.lock, color: Colors.grey,),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
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
                                  return "Please Enter Password";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 10,),

                            TextFormField(
                              controller: confirmPassword,
                              style: TextStyle(color: Colors.grey),
                              obscureText: !isConfirmPasswordVisible,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.lock, color: Colors.grey,),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
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
                                  return "Please Enter Password";
                                }
                                if (password.value != confirmPassword.value) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
              
                      SizedBox(height: 20,),
              
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Consumer<AuthrizationProvider>(
                          builder: (context, provider, child) {
                            return provider.loading ? Center(child: CircularProgressIndicator(color: Colors.white,),) : 
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  bool success = await provider.signUp(name.text, email.text, password.text);
                                  if (success) {
                                    context.read<Backgroundimageprovider>().stopAutoSlide();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ), (value) => false);
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
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            );
                          },
                        )
                      ),
                                          
                      SizedBox(height: 5,),
                                          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                color: AppColors.textSecondary
                              )
                            ),
                          ),
                      
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
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