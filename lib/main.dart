import 'package:flutter/material.dart';
import 'package:nike/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontFamily: 'yekan', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(
              bodyMedium: defaultTextStyle,
              bodySmall: defaultTextStyle.apply(
                  color: LightThemeColors.secondaryTextColor),
              //headline6
              titleLarge:
                  defaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
          colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.red,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: LightThemeColors.secondaryColor,
            foregroundColor: LightThemeColors.secondaryTextColor,
          )),
      home: const Directionality(
          textDirection: TextDirection.rtl,
          child: MyHomePage(title: 'فروشگاه نایک')),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'دکمه ی پلاس را لمس نمایید',
            ),
            Text(
              'دکمه ی پلاس را لمس نمایید',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'دکمه ی پلاس را لمس نمایید',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
