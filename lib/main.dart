import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hr;
import 'package:pick/firebase_options.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart' as my_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const hr.ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        title: 'Pickem App',
        onGenerateRoute: my_router.Router.generateRoute,
      ),
    );
  }
}
