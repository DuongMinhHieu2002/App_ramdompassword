import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Password Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _password = '';
  bool _excludeNumbers = false;
  bool _shortPassword = false;
  void _generatePassword() {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#\$%^&*()';
    final String numbers = '0123456789';
    final Random rand = Random();
    String newPassword = '';
    int length = 16;
    if (_shortPassword) {
      length = 8;
    }
    for (int i = 0; i < length; i++) {
      String char = chars[rand.nextInt(chars.length)];
      if (_excludeNumbers && numbers.contains(char)) {
        // If excludeNumbers is true and the character is a number, generate a new character
        while (numbers.contains(char)) {
          char = chars[rand.nextInt(chars.length)];
        }
      }
      newPassword += char;
    }
    setState(() {
      _password = newPassword;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _password));
    SnackBar(
      content: Text('Copied to clipboard'),
      duration: Duration(seconds: 1),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Password Generator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '$_password',
                      style: TextStyle(fontSize: 24),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _password = '';
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

                  ElevatedButton(
                    child: Text('Generate my  Password'),
                    onPressed: _generatePassword,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Copy to  your Clipboard'),
                    onPressed: _copyToClipboard,
                  ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Checkbox(
                    value: _excludeNumbers,
                    onChanged: (bool? value) {
                      setState(() {
                        _excludeNumbers = value ?? false;
                      });
                    },
                  ),
                  Text('Exclude numbers'),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Checkbox(
                    value: _shortPassword,
                    onChanged: (bool? value) {
                      setState(() {
                        _shortPassword = value ?? false;
                      });
                    },
                  ),
                  Text('Short password'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
