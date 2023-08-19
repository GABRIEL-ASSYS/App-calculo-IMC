import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //definição da página inicial do app
    home: Home(),
    //tirar o debug
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();

  String _texto = "Informe seus dados!"; //texto inicial

  //GlobalKey para validar o fomulário
  GlobalKey<FormState> _validacao = GlobalKey<FormState>();

  void _limparCampos() {
    //limpa os campos
    peso.text = '';
    altura.text = '';

    //atualizar o estado para mostrar o texto inicial e recriar a chave global
    setState(() {
      _texto = "Informe seus dados!";
      _validacao = GlobalKey<FormState>();
    });
  }

  void calcularIMC() {
    double pesoDigitado = double.parse(peso.text);
    double alturaDigitada = double.parse(altura.text);
    double imc = pesoDigitado / (alturaDigitada * alturaDigitada);

    //Atualizar o estado e mostrar o resultado com base no imc calculado
    setState(() {
      if (imc < 18.6) {
        _texto = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _texto = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _texto = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _texto = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _texto = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _texto = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        backgroundColor: Colors.green, // Cor de fundo da app bar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          )
        ],
      ),
      backgroundColor: Colors.white, // Cor de fundo do app
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), // Espaçamento das bordas
        child: Form(
          key: _validacao, // Chave global do formulário
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Preencher a largura
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number, // Teclado numérico
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: peso,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number, // Teclado numérico
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: altura,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0, // Altura do Botão
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validacao.currentState!.validate()) {
                        calcularIMC();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green)
                  ),
                ),
              ),
              Text(
                _texto,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
