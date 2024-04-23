import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/barbershop_theme.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/widgets/barbarshop_loader.dart';
import 'package:pj_barbershop_unifeob/src/features/auth/login/login_page.dart';
import 'package:pj_barbershop_unifeob/src/features/splash/splash_page.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarberShopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DW BarberShop',
          theme: BarbershopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login':(_) => const LoginPage(),
            '/home/adm':(_) => const Text('ADM'), 
            '/home/employee':(_) => const Text('Employee'),  
          },
        );
      },
    );
  }
}
