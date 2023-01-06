import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hypegym/models/user.dart';
//import 'package:hypegym/pages/edit_profile_page.dart';
import 'package:hypegym/pages/login_page.dart';
import 'package:hypegym/services/api_service.dart';

class AdminProfiePage extends StatefulWidget {
  const AdminProfiePage({Key? key}) : super(key: key);

  @override
  State<AdminProfiePage> createState() => _AdminProfiePageState();
}
// buraya adminin bilgilerini backendden cekmemz ve edit sayfasina bunu gondermemiz lazim
class _AdminProfiePageState extends State<AdminProfiePage> {

  final ApiService apiService = ApiService();
  final storage = const FlutterSecureStorage();
  late final User user;
  late final UserDto profile;

  @override
  void initState() async{
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      initasync();
    });


  }

  void initasync() async{
    user = User.fromJson(jsonDecode(await storage.read(key: "user") as String));
    var res = await apiService.getUser(user.ID) ;
    profile = UserDto.fromJson(jsonDecode(res!.body));
    print(profile.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        storage.delete(key: "token");
                        storage.delete(key: "user");
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.greenAccent.shade400,
                        size: 24,
                      ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PROFILE",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Eray Ozkan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "erayozkan@gmail.com",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "+90 539 939 39 39",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminGymPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                      minimumSize: const Size(200, 30),
                      maximumSize: const Size(200, 30),
                    ),
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(200, 30),
                      maximumSize: const Size(200, 30),
                    ),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.greenAccent.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

