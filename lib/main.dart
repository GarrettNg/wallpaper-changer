import 'dart:io';

import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

import 'package:wallpaper_changer/wallpaper.dart';

void main() => runApp(WallpaperChanger());

class WallpaperChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: HomePage(),
      );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? path;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Stack(
        children: <Widget>[
          if (path != null)
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(
                path!,
                fit: BoxFit.cover,
              ),
            ),
          Positioned(
            bottom: 8.0,
            right: 16.0,
            child: ButtonBar(
              buttonPadding: const EdgeInsets.all(16.0),
              children: <Widget>[
                MaterialButton(
                  color: Colors.black54,
                  onPressed: () {
                    final file = OpenFilePicker();
                    file.hidePinnedPlaces = true;
                    file.forcePreviewPaneOn = true;
                    file.filterSpecification = {
                      'PNG Files': '*.png',
                      'JPEG Files': '*.jpg; *.jpeg',
                      'All Files': '*'
                    };
                    file.title = 'Select an image';
                    final result = file.getFile();
                    if (result != null) {
                      setState(() => path = result);
                    }
                  },
                  child: Text(
                    'Choose File',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.black54,
                  onPressed: () {
                    if (path != null) {
                      Wallpaper.set(path!);
                    }
                  },
                  child: Text(
                    'Set Wallpaper',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
