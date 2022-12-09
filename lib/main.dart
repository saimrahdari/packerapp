import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Controllers/Cubits/page_view_cubit.dart';
import 'package:fyp/Screens/BottomNavigationScreens/bottom_navigation_screen.dart';
import 'Screens/Authentication/create_account_login_screen.dart';
import 'Services/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; //import http

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_test_51M7gowFnFqGxUJTbXxnMOSinTt2O5KoZuHfNDy8hQdNEThuGAbLP2viHvMAu8qtZk7sjowgTMf8hEPcm4qcpVVd300hyKkoIBD";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

User? currentFirebaseUser = FirebaseAuth.instance.currentUser;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setCountries();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageViewCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const BottomNavigationScreen();
                } else {
                  return const CreateAccountScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
