import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class CountDown extends ValueNotifier<int>
{
  late StreamSubscription sub;
  CountDown({required int from}):super(from)
  {
    sub=Stream.periodic
    (
      const Duration(seconds: 1),
      (v)=>from-v
    ).takeWhile((element) => element>=0)
    .listen((event) 
    {
      value=value;
    });
  }

  @override
  void dispose() 
  {
    sub.cancel();
    super.dispose();
  }
}

class MainApp extends HookWidget 
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final countDown=useMemoized(()=>CountDown(from: 20));
    final notifier=useListenable(countDown);
    return  MaterialApp
    (
      home: Scaffold
      (
        appBar: AppBar
        (
          centerTitle: true,
          title: const Text('HomePage'),
        ),
        body: Center
        (
          child: Text(notifier.value.toString()),
        ),
      ),
    );
  }
}
