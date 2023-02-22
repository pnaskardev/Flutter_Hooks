import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testing_flutter_hooks/utils/utils.dart';

void main() {
  runApp(const MainApp());
}

const url=
'https://images.unsplash.com/photo-1677054727286-feefd75880b5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80';

class MainApp extends HookWidget 
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    // DOES NOT PERSIST STATE 
    // final image=useFuture
    // (
    //   NetworkAssetBundle(Uri.parse(url))
    //   .load(url)
    //   .then((data)=>data.buffer.asUint8List())
    //   .then((data) => Image.memory(data),)
    // );

    // SAVES THE STATE OF THE IMAGE
    final future=useMemoized
    (
      ()=>NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data)=>data.buffer.asUint8List())
        .then((data) => Image.memory(data),)
    );
    final snapshot=useFuture(future);
    return  MaterialApp
    (
      home: Scaffold
      (
        appBar: AppBar
        (
          centerTitle: true,
          title: const Text('HomePage'),
        ),
        body:  Center
        (
          child: Column
          (
            children: 
            [
              snapshot.data
            ].compactMap().toList(),
          ),
        )
      ),
    );
  }
}
