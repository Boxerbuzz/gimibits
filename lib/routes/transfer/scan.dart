import 'package:flutter/material.dart';

import '../../exports.dart';

const _flashOn = 'FLASH ON';
const _flashOff = 'FLASH OFF';
const _frontCamera = 'FRONT CAMERA';
const _backCamera = 'BACK CAMERA';

class ScanBarCode extends StatefulWidget {
  @override
  _ScanBarCodeState createState() => _ScanBarCodeState();
}

class _ScanBarCodeState extends State<ScanBarCode> {
  var qrText = '';
  var flashState = _flashOn;
  var cameraState = _frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 40.0,
            ),
            child: Container(
              height: 70.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: CommonIconButton(
                      onTap: () => Navigator.pop(context),
                      icon: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          R.I.icBack,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: CommonIconButton(
                      onTap: () {
                        if (controller != null) {
                          controller.toggleFlash();
                          if (_isFlashOn(flashState)) {
                            setState(() {
                              flashState = _flashOff;
                            });
                          } else {
                            setState(() {
                              flashState = _flashOn;
                            });
                          }
                        }
                      },
                      icon: flashState == 'FLASH ON'
                          ? Padding(
                              padding: EdgeInsets.all(2.0),
                              child: SvgPicture.asset(
                                R.I.icFlashOn,
                                height: 24.0,
                                width: 24.0,
                                color: Colors.amber,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(2.0),
                              child: SvgPicture.asset(
                                R.I.icFlashOn,
                                height: 24.0,
                                width: 24.0,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: CommonIconButton(
                      onTap: () {
                        if (controller != null) {
                          controller.flipCamera();
                          if (_isBackCamera(cameraState)) {
                            setState(() {
                              cameraState = _frontCamera;
                            });
                          } else {
                            setState(() {
                              cameraState = _backCamera;
                            });
                          }
                        }
                      },
                      icon: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          R.I.icSwitchCam,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return _flashOn == current;
  }

  bool _isBackCamera(String current) {
    return _backCamera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        //qrText = scanData;
      });
    });
  }
}
