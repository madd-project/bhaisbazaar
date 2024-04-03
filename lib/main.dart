import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhais ki Calculation',
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Broo Profit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController initialController = TextEditingController();
  TextEditingController finalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    priceController.addListener(updateNoOfStocks);
    initialController.addListener(updateNoOfStocks);
  }

  void updateNoOfStocks() {
    setState(() {
      noOfStocks = totalNumberOfStocks() as double;
    });
  }

  int totalNumberOfStocks() {
    setState(() {
      if (priceController.text.isNotEmpty &&
          initialController.text.isNotEmpty) {
        double price = double.parse(priceController.text);
        double initial_price = double.parse(initialController.text);
        if (isCheckBoxChecked == true) {
          noOfStocks = (5 * price) / initial_price;
        } else {
          noOfStocks = price / initial_price;
        }
      }
    });

    return noOfStocks.toInt();
  }

  @override
  void dispose() {
    // Dispose the controllers
    priceController.dispose();
    initialController.dispose();
    finalController.dispose();
    super.dispose();
  }

  double result = 0;
  String buyOrSell = 'buy';
  bool isCheckBoxChecked = true;
  double noOfStocks = 0;

  void computePandL() {
    setState(() {
      double price = double.parse(priceController.text);
      double initial_price = double.parse(initialController.text);
      double final_price = double.parse(finalController.text);

      if (isCheckBoxChecked == true) {
        // Perform some action if the checkbox is checked
        if (buyOrSell == 'buy') {
          result =
              ((5 * price) / initial_price) * (final_price - initial_price);
          result = double.parse(result.toStringAsFixed(2));
        } else if (buyOrSell == 'sell') {
          result =
              ((5 * price) / initial_price) * (initial_price - final_price);
          result = double.parse(result.toStringAsFixed(2));
        }
      } else {
        // Perform some action if the checkbox is not checked
        if (buyOrSell == 'buy') {
          result = ((price) / initial_price) * (final_price - initial_price);
          result = double.parse(result.toStringAsFixed(2));
        } else if (buyOrSell == 'sell') {
          result = ((price) / initial_price) * (initial_price - final_price);
          result = double.parse(result.toStringAsFixed(2));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the computePandL method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Total Money',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: initialController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Initial Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: finalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Final Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Intraday',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      value: isCheckBoxChecked,
                      onChanged: (value) {
                        setState(() {
                          isCheckBoxChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          buyOrSell = 'buy';
                        });
                        computePandL();
                        print('Buy');
                        // TODO: Implement buy button logic
                      },
                      child: Text('Buy'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          buyOrSell = 'sell';
                          print('Sell');
                        });
                        computePandL();

                        print(totalNumberOfStocks());
                        // TODO: Implement sell button logic
                      },
                      child: Text('Sell'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    ' rs. $result',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'total stocks: ${totalNumberOfStocks()}',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.grey),
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
