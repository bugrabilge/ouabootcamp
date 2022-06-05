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

  void seceneklereEkle() {
    if (secenekler.isNotEmpty) {
      secenekler.clear();
    }
    for (int i = 0; i < textEditingControllerlar.length; i++) {
      secenekler.add(textEditingControllerlar[i].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Karar Ver"),
          foregroundColor: Colors.black,
          elevation: 10,
          centerTitle: true,
          backgroundColor: Colors.white,
          //AppBar
          leading: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 35,
            color: Colors.black,
            onPressed: () {
              final eklenecekController = TextEditingController();
              final eklenecekAlan = Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: eklenecekController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText:
                            " ${textEditingControllerlar.length + 1}. Seçenek",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        )),
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
              iconSize: 30,
              color: Colors.black,
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: textFieldlar.length,
                  itemBuilder: (context, indis) {
                    return textFieldlar[indis];
                  }),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 28),
                  minimumSize: const Size(
                    250,
                    50,
                  ),
                  elevation: 300,
                  primary: Colors.deepOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  onPrimary: Colors.black,
                ),
                onPressed: () async {
                  seceneklereEkle();
                  var random = Random();
                  String karar = "Yeni bir seçenek giriniz";
                  if (secenekler.isNotEmpty) {
                    karar = secenekler[random.nextInt(secenekler.length)];
                  }

                  final alert = AlertDialog(
                    backgroundColor: Colors.deepOrangeAccent,
                    title: const Text("Kararınız:",
                        style: TextStyle(color: Colors.white)),
                    content: Text(karar),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Yeni Kararınız",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => alert,
                  );
                  setState(() {});
                },
                child: const Text('Karar Ver'))
          ],
        )));
  }
}
