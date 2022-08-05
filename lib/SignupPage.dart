import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/LoginPage.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SignupPage()
  ));
}
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool hide = true;
  bool hide1 = true;
  TextEditingController Password = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purpleAccent,
      body: Stack(
        children: [
          Padding(padding: EdgeInsets.only(top: 30.0, left: 40.0),
            child: Text(
              'Sign Up ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.30),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                topLeft: Radius.circular(50.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: Email,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: Password,
                  obscureText: hide,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(onPressed: (){
                      setState((){
                        hide = !hide;
                      });
                    }, icon: hide? Icon(Icons.visibility_off): Icon(Icons.visibility),

                    ),
                  ),
                ),

                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: ConfirmPassword,
                  obscureText: hide1,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(onPressed: (){
                      setState((){
                        hide1 = !hide1;
                      });
                    }, icon: hide1? Icon(Icons.visibility_off): Icon(Icons.visibility),

                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),

               /* Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){}, child: Text('Forgot Password?')),
                ),*/

                Center(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 80.0),
                    ),
                    onPressed: (){
                      if(Password.text != ConfirmPassword.text) {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('Messages'),
                            content: Text('Password Do Not Match!!!'),
                          );
                        });
                      }
                      else {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: Email.text,
                            password: Password.text) .then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      }
                    },
                    child: Text(
                        'Sign Up',style: TextStyle(color: Colors.black)
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Already have an account?'
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                    }, child: Text('Sign In')
                    ),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}