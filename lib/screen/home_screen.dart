import 'package:flutter/material.dart';
import 'package:medium_extractor_frontend/api/extractor_api.dart';
import 'package:medium_extractor_frontend/tools/show_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController linkController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    linkController.dispose();
  }

  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/bg.jpg',
                ))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Medium  to PDF',
                style: TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Service allow to get a full article for free in PDF',
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 241, 239, 239)),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: linkController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'https://medium.com/simform-engineering/streamline-flutter-development-with-clean-architecture-a850b182cfb9',
                    prefixIcon: Icon(
                      Icons.link,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isDownloading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (linkController.text.isEmpty || !linkController.text.startsWith('https://')) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          showMessage(context, 'Link is empty or invalid');
                        } else {
                          setState(() {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            isDownloading = !isDownloading;
                          });
                          await ExtractorApi().downloadPdf(context, linkController.text.trim());

                          setState(() {
                            isDownloading = !isDownloading;
                            linkController.clear();
                          });
                        }
                      },
                      child: const Text('Download')),
              const SizedBox(
                height: 8,
              ),
              isDownloading
                  ? const Text(
                      'Download will start automatically, during 10-20 seconds...',
                      style: TextStyle(color: Color.fromARGB(255, 232, 228, 228)),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
