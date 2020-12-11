import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  File pickedImage;
  var imageFile;
  List<Rect> rect = new List<Rect>();

  bool isFaceDetected = false;

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    imageFile = await awaitImage.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      imageFile = imageFile;
      pickedImage = awaitImage;
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

    final List<Face> faces = await faceDetector.processImage(visionImage);
    if (rect.length > 0) {
      rect = new List<Rect>();
    }
    for (Face face in faces) {
      rect.add(face.boundingBox);

      final double rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
      print('the rotation y is ' + rotY.toStringAsFixed(2));
      print('the rotation z is ' + rotZ.toStringAsFixed(2));
    }

    setState(() {
      isFaceDetected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          isFaceDetected
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 20),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: FittedBox(
                      child: SizedBox(
                        width: imageFile.width.toDouble(),
                        height: imageFile.height.toDouble(),
                        child: CustomPaint(
                          painter:
                              FacePainter(rect: rect, imageFile: imageFile),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickImage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({@required this.rect, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/*
  File _image;
  final picker = ImagePicker();

  void _getImage() async {
    final PickedFile picked =
        await picker.getImage(source: ImageSource.gallery);

    if (picked == null) return;
    setState(() {
      _image = File(picked.path);
    });
  }

  Future<void> faceDetection() async {
    _getImage();
    final File imageFile = _image;
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

    final List<Face> faces = await faceDetector.processImage(visionImage);

    for (Face face in faces) {
      final Rectangle<int> boundingBox = face.boundingBox as Rectangle<int>;

      final double rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark leftEar = face.getLandmark(FaceLandmarkType.leftEar);
      if (leftEar != null) {
        final Point<double> leftEarPos = leftEar.position as Point<double>;
      }

      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double smileProb = face.smilingProbability;
      }

      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int id = face.trackingId;
      }
    }

    faceDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
   */

/*
FirebaseVision _vision;
  dynamic _scanResults;
  // Detector _currentDetector = Detector.visionEdgeLabel;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    List<FirebaseCameraDescription> cameras = await camerasAvailable();
    _vision = FirebaseVision(cameras[0], ResolutionSetting.high);
    _vision.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    CustomPainter painter;

    final Size imageSize = Size(
      _vision.value.previewSize.height,
      _vision.value.previewSize.width,
    );

    _vision
        .addVisionEdgeImageLabeler('assets/faceML', ModelLocation.Local)
        .then((onValue) {
      onValue.listen((onData) {
        setState(() {
          _scanResults = onData;
        });
      });
    });
    if (_scanResults is! List<VisionEdgeImageLabel>) return noResultsText;
    painter = VisionEdgeLabelDetectorPainter(imageSize, _scanResults);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _vision == null
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FirebaseCameraPreview(_vision),
                _buildResults(),
              ],
            )
          : Container(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildImage(),
    );
  }

  void dispose() {
    _vision.dispose().then((_) {
      _vision.visionEdgeImageLabeler.close();
    });

    super.dispose();
*/
