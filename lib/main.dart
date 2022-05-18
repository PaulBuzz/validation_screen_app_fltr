import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TBR Validation Screen',
      home: MobNumberTextField(),
    );
  }
}

class MobNumberTextField extends StatefulWidget {
  createState() => MobNumberTextFieldState();
}

class MobNumberTextFieldState extends State<MobNumberTextField> {
  final controller = MaskedTextController(mask: "(000) 000-0000");
  bool _btnActive = false;
  String _textMsg = '\nGet Started';

  void _text() {
    setState(() {
      _textMsg = '\nProceed';
    });
  }

  void resetAll() {
    controller.clear();
  }

  changesOnField() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(changesOnField);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Text(
              _textMsg,
              style: TextStyle(
                  fontSize: 22.5,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(199, 31, 31, 31)),
              textAlign: TextAlign.end,
            ),
            Spacer(),
            Center(
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: ('(201) 555-0123'),
                  helperText: ('Enter your phone number'),
                  helperStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            resetAll();
                          },
                          icon: Icon(Icons.cancel_rounded,
                              size: 18.0, color: Colors.grey),
                        )
                      : null,
                ),
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    _btnActive = value.length == 14 ? true : false;
                  });
                },
              ),
            ),
            SizedBox(height: height * 0.032),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                    ),
                    child: Icon(Icons.arrow_forward_sharp),
                    onPressed: _btnActive == true ? _text : null),
              ],
            )
          ],
        ),
      ),
    );
  }
}
