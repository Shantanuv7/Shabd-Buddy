import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController lang = TextEditingController();
  String? out;

  String fromLanguage = 'English';
  String toLanguage = 'Hindi';

  final Map<String, String> languageMap = {
    'English': 'en',
    'Hindi': 'hi',
    'Marathi': 'mr',
  };

  void trans() {
    final translator = GoogleTranslator();

    String? sourceLang = languageMap[fromLanguage];
    String? targetLang = languageMap[toLanguage];

    if (sourceLang == null || targetLang == null) return;

    translator
        .translate(lang.text, from: sourceLang, to: targetLang)
        .then((translation) {
      setState(() {
        out = translation.text;
      });
    }).catchError((e) {
      setState(() {
        out = 'Error: $e';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Shabd',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'PoppinsBold',
                ),
              ),
              TextSpan(
                text: ' Buddy',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontFamily: 'PoppinsBold',
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF121212),
                  ),
                  child: TextField(
                    controller: lang,
                    minLines: 5,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'PoppinsReg',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter text to translate",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'PoppinsReg',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: fromLanguage,
                    isExpanded: true,
                    items: languageMap.keys.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text("From: $lang"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: toLanguage,
                    isExpanded: true,
                    items: languageMap.keys.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text("To: $lang"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[400],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: SelectableText(
                      out ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsReg',
                      ),
                      showCursor: true,
                      cursorColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: trans,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    "Translate",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoppinsBold',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
