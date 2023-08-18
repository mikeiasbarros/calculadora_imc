import 'package:flutter/material.dart';
import 'package:testeee/components/rounded_input_field.dart';

import 'consts.dart';

void main() {
  runApp(MyApp());
}

class IMC {
  String nome;
  double peso;
  double altura;

  IMC(this.nome, this.peso, this.altura);

  double calcularIMC() {
    return peso / (altura * altura);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<IMC> imcList = [];

  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _calcularIMC() {
    String nome = nomeController.text;
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    IMC imc = IMC(nome, peso, altura);
    double valorIMC = imc.calcularIMC();

    String mensagem;

    if (valorIMC < 16) {
      mensagem =
          'Você está em estado de magreza grave. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 16 && valorIMC < 17) {
      mensagem =
          'Você está em estado de magreza moderada. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 17 && valorIMC < 18.5) {
      mensagem =
          'Em estado de magreza leve. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 18.5 && valorIMC < 25) {
      mensagem =
          'Você está saudável. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 25 && valorIMC < 30) {
      mensagem =
          'Você está sobrepeso. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 30 && valorIMC < 35) {
      mensagem =
          'Você está com obesidade grau I. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else if (valorIMC >= 35 && valorIMC < 40) {
      mensagem =
          'Você está com obesidade grau II. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    } else {
      mensagem =
          'Você está com obesidade grau III. Seu IMC é ${valorIMC.toStringAsFixed(2)}.';
    }

    setState(() {
      imcList.add(imc);
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado do IMC'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: $nome'),
              SizedBox(height: 8),
              Text(mensagem),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: kPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedInputField(
                icon: Icons.person,
                hintText: 'Informe seu nome',
                controller: nomeController,
                textInputType: TextInputType.name),
            RoundedInputField(
                icon: Icons.accessibility,
                hintText: 'Informe sua altura',
                controller: alturaController,
                textInputType: TextInputType.numberWithOptions()),
            RoundedInputField(
                icon: Icons.line_weight,
                hintText: 'Informe seu peso: (kg)',
                controller: pesoController,
                textInputType: TextInputType.numberWithOptions()),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação a ser executada quando o botão é pressionado.
                _calcularIMC();
              },
              child: Text("SABER IMC".toUpperCase()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  minimumSize: Size(size.width * .8, 24)
                  //fina o tamanho mínimo desejado
                  ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: imcList.length,
                itemBuilder: (context, index) {
                  IMC imc = imcList[index];
                  double valorIMC = imc.calcularIMC();
                  String categoriaIMC = '';

                  if (valorIMC < 16) {
                    categoriaIMC = 'Magreza Grave';
                  } else if (valorIMC < 17) {
                    categoriaIMC = 'Magreza Moderada';
                  } else if (valorIMC < 18.5) {
                    categoriaIMC = 'Magreza Leve';
                  } else if (valorIMC < 25) {
                    categoriaIMC = 'Saudável';
                  } else if (valorIMC < 30) {
                    categoriaIMC = 'Sobrepeso';
                  } else if (valorIMC < 35) {
                    categoriaIMC = 'Obesidade Grau I';
                  } else if (valorIMC < 40) {
                    categoriaIMC = 'Obesidade Grau II';
                  } else {
                    categoriaIMC = 'Obesidade Grau III';
                  }

                  return ListTile(
                    title: Text(
                        'Nome: ${imc.nome}\nIMC: ${valorIMC.toStringAsFixed(2)}'),
                    subtitle: Text('Categoria: $categoriaIMC'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
