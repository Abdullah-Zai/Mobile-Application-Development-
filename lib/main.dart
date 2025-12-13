import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mid_project/login.dart';
import 'package:mid_project/provider/theme_changer_provider.dart';
import 'package:provider/provider.dart';

// Add these imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Add these lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, themeChanger, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeChanger.themeMode,
          theme: themeChanger.lightTheme,
          darkTheme: themeChanger.darkTheme,
          home: const GetStarted(),
        );
      },
    );
  }
}

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ❌ removed backgroundColor
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/animation/Delivery.json',
              width: 300,
              height: 300,
            ),
          ),

          Text(
            'Delicious Food',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),
          const Text('We help you to find best and'),
          const Text('Delicious Food'),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/animation/pic.PNG', width: 30, height: 20),
              const SizedBox(width: 5),
              Image.asset('assets/animation/pic.PNG', width: 20, height: 20),
              const SizedBox(width: 5),
              Image.asset('assets/animation/pic.PNG', width: 20, height: 20),
            ],
          ),

          const SizedBox(height: 100),

          // ✅ Button now follows BLUE THEME
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
              );
            },
            child: const Text(
              'Get Started',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
