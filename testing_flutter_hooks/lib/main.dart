import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget 
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final controller=useTextEditingController();
    final text=useState('');
    useEffect(()
    {
      controller.addListener(() 
      {
        text.value=controller.text;
      });
      return null;
    },[controller]);
    return  MaterialApp
    (
      home: Scaffold
      (
        appBar: AppBar
        (
          centerTitle: true,
          title: const Text('HomePage'),
        ),
        body:  Column
        (
          children: 
          [
            TextFormField
            (
              controller: controller,
            ),
            Text('You typed ${text.value}')
          ],
        )
      ),
    );
  }
}
