import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Image.asset("assets/test.jpg", fit: BoxFit.cover)),
              const Expanded(child: MapWidget(lat: 39.9, lng: 116.4)),
            ],
          ),
          const Positioned(
              top: 0,
              bottom: 0,
              right: 200,
              left: 0,
              child: Blurred(
                child: Center(
                  child: Text(
                    "some text\nabove blurred content",
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final double lat;
  final double lng;

  const MapWidget({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 15),
    );
  }
}

class Blurred extends StatelessWidget {
  final Widget? child;
  final double blurSigma;

  const Blurred({
    super.key,
    this.blurSigma = 8,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (blurSigma == 0) {
      return child ?? const SizedBox.shrink();
    } else {
      var blurred = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: child,
      );
      return ClipRect(child: blurred);
    }
  }
}
