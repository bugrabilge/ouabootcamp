import 'package:flutter/material.dart';
import 'dart:math';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);
  static const id = "ana_sayfa";

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final List<String> secenekler = [];
  final List<Widget> textFieldlar = [];
  final List<TextEditingController> textEditingControllerlar = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController controller in textEditingControllerlar) {
      controller.dispose();
    }
    super.dispose();
  }
  void seceneklereEkle(){
    if(secenekler.isNotEmpty){
      secenekler.clear();
    }
    for(int i = 0; i < textEditingControllerlar.length; i++){
      secenekler.add(textEditingControllerlar[i].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Randomla"),
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final eklenecekController = TextEditingController();
              final eklenecekAlan = Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: eklenecekController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Seçenek ${textEditingControllerlar.length + 1}",
                    ),
                  ));

              setState(() {
                textEditingControllerlar.add(eklenecekController);
                textFieldlar.add(eklenecekAlan);
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (textFieldlar.isNotEmpty) {
                  textFieldlar.removeLast();
                  textEditingControllerlar.removeLast();
                  setState(() {});
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: textFieldlar.length,
                  itemBuilder: (context, indis) {
                    return textFieldlar[indis];
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  seceneklereEkle();
                  var random = Random();
                  String karar = "Önce seçenek gir";
                  if(secenekler.isNotEmpty){
                    karar = secenekler[random.nextInt(secenekler.length)];
                  }

                  final alert = AlertDialog(
                    title: Text("Karar verdim"),
                    content: Text("Bence :" + karar),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Teşekkür ederim"),
                      ),
                    ],
                  );
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => alert,
                  );
                  setState(() {});
                },
                child: const Text('Random'))
          ],
        ));
    }
}
