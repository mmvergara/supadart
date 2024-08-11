import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supadart_web/generator/generator.dart';
import 'package:supadart_web/generator/swagger.dart' hide Column;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supadart',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C1C1C),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xFFE0E0E0),
              displayColor: const Color(0xFFE0E0E0),
            ),
        fontFamily: 'Arial',
      ),
      home: const MyHomePage(title: 'Supadart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String supabaseUrl = '';
  String supabaseAnonKey = '';
  bool isLoading = false;
  bool isFlutter = true;
  bool isSeperated = false;

  String copyStatus = 'Copy to Clipboard';
  List<GeneratedFile> output = [];

  Future<void> handleGenerate() async {
    setState(() {
      isLoading = true;
    });

    final swaggerData =
        await fetchDatabaseSwagger(supabaseUrl, supabaseAnonKey);
    if (swaggerData == null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error fetching Supabase Swagger"),
          duration: Duration(milliseconds: 300),
        ));
        isLoading = false;
      });
      return;
    }

    final filesGenerated =
        generateModelFiles(swaggerData, isFlutter, isSeperated, null);

    setState(() {
      output = filesGenerated;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                const Text(
                  'Supadart',
                  style: TextStyle(
                    color: Color(0xFF37996B),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  child: const Text(
                    'Github Repository',
                    style: TextStyle(color: Color(0xFF4493D1)),
                  ),
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://github.com/mmvergara/supadart');

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                    'This tool will generate Dart classes from your Supabase schema.'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Dart Project  '),
                    Switch(
                      value: isFlutter,
                      onChanged: (value) {
                        setState(() {
                          isFlutter = value;
                        });
                      },
                      activeColor: const Color(0xFF37996B),
                    ),
                    const Text('  Flutter Project'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Single File     '),
                    Switch(
                      value: isSeperated,
                      onChanged: (value) {
                        setState(() {
                          isSeperated = value;
                        });
                      },
                      activeColor: const Color(0xFF37996B),
                    ),
                    const Text('  Seperated Files'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Generate via API',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'SUPABASE_URL',
                    filled: true,
                    fillColor: const Color(0xFF272727),
                    hintStyle: const TextStyle(color: Color(0xFF6E6E6E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF363636)),
                    ),
                  ),
                  onChanged: (value) => setState(() => supabaseUrl = value),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'SUPABASE_ANON_KEY',
                    filled: true,
                    fillColor: const Color(0xFF272727),
                    hintStyle: const TextStyle(color: Color(0xFF6E6E6E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF363636)),
                    ),
                  ),
                  onChanged: (value) => setState(() => supabaseAnonKey = value),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: isLoading ? null : handleGenerate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF37996B),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF42C286)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(isLoading ? 'Generating...' : 'Generate'),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF272727),
                    border: Border.all(color: const Color(0xFF363636)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child:
                      // Output generated classes
                      output.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Generated Classes',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                for (final file in output)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E1E1E),
                                      border: Border.all(
                                          color: const Color(0xFF363636)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              file.fileName,
                                              style: TextStyle(
                                                color: Colors.green[700],
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: file.fileContent));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "${file.fileName} copied to clipboard"),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF37996B),
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                              child: const Text('Copy'),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(height: 8),
                                        // Container(
                                        //   padding: const EdgeInsets.all(8),
                                        //   decoration: BoxDecoration(
                                        //     color: const Color(0xFF272727),
                                        //     borderRadius:
                                        //         BorderRadius.circular(4),
                                        //   ),
                                        //   child: Text(
                                        //     file.fileContent,
                                        //     style: const TextStyle(
                                        //       color: Color(0xFFE0E0E0),
                                        //       fontSize: 12,
                                        //       fontFamily: 'Courier New',
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                          : const Text(
                              'Generated classes will appear here',
                              style: TextStyle(
                                color: Color(0xFFE0E0E0),
                                fontSize: 14,
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
