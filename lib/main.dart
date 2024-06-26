import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CryptoCurrenciesListApp());
}

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Currencies List',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        primarySwatch: Colors.yellow,
        dividerColor: Colors.white24,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 31, 31, 31),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),
        textTheme: TextTheme(
            bodyMedium: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
            labelSmall: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w700,
                fontSize: 14)),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => CryptoListScreen(),
        '/coin': (context) => CryptoCoinScreen()
      },
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('CryptoCurrenciesList'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, i) {
            const coinName = 'Bitcoin';
            return ListTile(
              leading: SvgPicture.asset(
                'assets/svg/bitcoin_logo.svg',
                height: 30,
                width: 30,
              ),
              title: Text(
                coinName,
                style: theme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                '20000\$',
                style: theme.textTheme.labelSmall,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed('/coin', arguments: coinName);
              },
            );
          }),
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    // if (args == null) {
    //   log('You must provide args');
    //   return;
    // }
    // if (args is! String) {
    //   log('You must provide String args');
    //   return;
    // }

    assert(args != null && args is String, 'You must provide String args');
    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      ),
    );
  }
}
