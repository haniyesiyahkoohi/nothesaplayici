import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ders Not Hesaplama'),
          backgroundColor: Colors.blue,
        ),
        body: NotHesaplama(),
      ),
    );
  }
}

class NotHesaplama extends StatefulWidget {
  @override
  _NotHesaplamaState createState() => _NotHesaplamaState();
}

class _NotHesaplamaState extends State<NotHesaplama> {
  TextEditingController dersAdiController = TextEditingController();
  TextEditingController vizeNotController = TextEditingController();
  TextEditingController finalNotController = TextEditingController();
  TextEditingController krediController = TextEditingController();

  List<Ders> dersler = [];

  double genelOrtalama = 0.0;

  void _hesapla() {
    double toplamKredi = 0.0;
    double toplamAgirlikliNot = 0.0;

    for (var ders in dersler) {
      double agirlikliNot = (ders.vizeNot * 0.4) + (ders.finalNot * 0.6);
      toplamAgirlikliNot += agirlikliNot * ders.kredi;
      toplamKredi += ders.kredi;
    }

    setState(() {
      genelOrtalama = toplamAgirlikliNot / toplamKredi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: dersAdiController,
            decoration: InputDecoration(labelText: 'Ders Adı'),
          ),
          TextField(
            controller: vizeNotController,
            decoration: InputDecoration(labelText: 'Vize Notu'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: finalNotController,
            decoration: InputDecoration(labelText: 'Final Notu'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: krediController,
            decoration: InputDecoration(labelText: 'Kredi'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                dersler.add(
                  Ders(
                    dersAdiController.text,
                    double.parse(vizeNotController.text),
                    double.parse(finalNotController.text),
                    double.parse(krediController.text),
                  ),
                );
                _hesapla();
              });
            },
            child: Text('Ekle', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 48, 153, 240)),
          ),
          SizedBox(height: 20),
          Text(
            'Genel Ortalama: ${genelOrtalama.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 20),
          const Text(
            'Dersler:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: dersler.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dersler[index].dersAdi,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    'Ortalama: ${dersler[index].ortalama.toStringAsFixed(2)}'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Ders {
  String dersAdi;
  double vizeNot;
  double finalNot;
  double kredi;

  Ders(this.dersAdi, this.vizeNot, this.finalNot, this.kredi);

  double get ortalama {
    return (vizeNot * 0.4) + (finalNot * 0.6);
  }
}
