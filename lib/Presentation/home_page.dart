import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task/My_theme.dart';
import 'package:task/Presentation/custom_widgets/features_box.dart';
import 'package:task/Presentation/slide_menu.dart';
import 'package:task/data/openai_service.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  bool _speechEnabled = false;
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  final advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    try {
      _speechEnabled = await speechToText.initialize();
      if (!_speechEnabled) {
        print("Speech recognition not enabled or not supported on this device.");
      }
    } catch (e) {
      print("Error initializing speech recognition: $e");
    }
    setState(() {});
  }

  Future<void> startListening() async {
    if (_speechEnabled && await speechToText.hasPermission && !speechToText.isListening) {
      await speechToText.listen(onResult: onSpeechResult);
      setState(() {});
    }
  }

  Future<void> stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
      setState(() {});
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: advancedDrawerController,
      backdropColor: MyTheme.bgAppBar,
      drawer: SlideMenu(),
      child: Scaffold(
        backgroundColor: MyTheme.lightPink,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyTheme.bgAppBar,
          title: BounceInDown(
            child: const Text(
              'IntelliChat',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MyTheme.lightPink,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: advancedDrawerController.showDrawer,
            icon: const Icon(
              Icons.menu,
              color: MyTheme.menuColor,
              size: 42,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 140,
                        width: 140,
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: MyTheme.lightCircle.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 190,
                        width: 170,
                      ),
                    ),
                  ],
                ),
              ),
              FadeInRight(
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.border),
                      borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
                    ),
                    child: Text(
                      generatedContent == null
                          ? 'Good Morning, what task can I do for you?'
                          : generatedContent!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: generatedContent == null ? 22 : 18,
                        fontFamily: 'Cera Pro',
                      ),
                    ),
                  ),
                ),
              ),
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(generatedImageUrl!)),
                ),
              SlideInLeft(
                child: Visibility(
                  visible: generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 5, left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Here are a few features',
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: MyTheme.bgAppBar,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      child: const FeaturesBox(
                        color: MyTheme.firstBox,
                        title: 'ChatGPT',
                        text: 'A smarter way to stay organized and informed with ChatGPT.',
                      ),
                    ),
                    SlideInRight(
                      child: const FeaturesBox(
                        color: MyTheme.secondBox,
                        title: 'Dall-E',
                        text: 'Get inspired and stay creative with your personal assistant powered by Dall-E.',
                      ),
                    ),
                    SlideInLeft(
                      child: const FeaturesBox(
                        color: MyTheme.thirdBox,
                        title: 'Smart Voice Assistant',
                        text: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission && !speechToText.isListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }

              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
