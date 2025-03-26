import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/authentication/login.dart';

class UserScreen extends StatefulWidget {
  final String username;
  final String pfpUrl;
  const UserScreen({super.key, required this.username, required this.pfpUrl});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String username;
  late String pfpUrl;

   void initState() {
    super.initState();
    username = widget.username;
    pfpUrl = widget.pfpUrl;
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
       body: Center(
         child: SingleChildScrollView(
           child: Column(
                  children: [
                    ClipOval(
                      child: Image.network(
                        pfpUrl,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        },
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(username,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 15,),
                     TextButton(
                        onPressed: () {
                         FirebaseAuth.instance.signOut();
                           Navigator.push(
                          context, MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC25668),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                  ],
                ),
         ),
       )
          
       );

  }
}