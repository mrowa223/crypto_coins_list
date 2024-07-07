import 'dart:async';

import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    super.initState();
    final completer = Completer<void>();
    _cryptoListBloc.add(LoadCryptoList(completer));
    completer.future.catchError((error) {
      // Handle error if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          _cryptoListBloc.add(LoadCryptoList(completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(
                    coin: coin,
                  );
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const Text('Please try again later'),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        final completer = Completer<void>();
                        _cryptoListBloc.add(LoadCryptoList(completer));
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cryptoListBloc.close();
    super.dispose();
  }
}
