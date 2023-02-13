import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Constant {
  static const String accessTokenKey = 'accessToken';

  static const String isFirstTime = 'FIRST_TIME';

  static const String userNotFound = 'error_auth_invalid_user';

  static const String userRoleUpdated = 'error_auth_required_resign_in';

  static const String userDisabled = 'error_auth_user_is_disabled';


  static const String pieces = 'pieces';

  static const String typeCollect = 'c';

  static const String typeManufacture = 'm';

  static const String languageEnglish = 'en';

  static const String languageJapanese = 'ja';

  static const int itemConfirmed = 1;

  static const int defaultId = -1;

  static const int defaultTaskTemplate = 1;

  static const int defaultHazardous  = 0;

  static const int isHazardous = 1;

  static const int timeOut20s = 20;

  static const int timeOut30s = 30;

  static const int successCode = 201;

  static const int radioButtonContainer = 0;
  static const int radioButtonStorage = 1;
  static const int radioButtonContainerDelivery = 1;
  static const int radioButtonStorageDelivery = 0;

// Fields select input item screen
  static const int fieldContainer = 0;
  static const int fieldStorage = 1;
  static const int fieldContainerDelivery = 1;
  static const int fieldStorageDelivery = 0;
  static const int itemDelivery = 0;
  static const int containerDelivery = 1;
  static const int defaultDisposalItemType = 1;
  static const int typeItemFinished = 0;
  static const int typeItemDisposal = 1;
  static const int disposalItemSelected = 1;
  static const int disposalItemNotSelected = 2;
  static const int productSelected = 1;
  static const int productNotSelected = 0;

  static const int greaterConfirm = 1;
  static const int greaterCancel = 0;
  static const int lessCancel = 0;
  static const int lessTick = 1;
  static const int lessUnTick = 2;


  static const MethodChannel channel =
  MethodChannel('perfect_hardware_control');


  /// Hardware event change monitor flow
  static final StreamController<String> streamController =
  StreamController.broadcast();

  /// Hardware event change monitor name
  static const String _hardwareEventChangeListenerName = 'hardwareEventChangeListener';

  /// method invoke handler
  static Future<dynamic> _methodCallHandler(call) async {
    if (call.method == _hardwareEventChangeListenerName) {
      String hardwareEvent = call.arguments;
      streamController.add(hardwareEvent);
    }
  }

  static Stream<String> get streamHardware {
    channel.setMethodCallHandler(_methodCallHandler);
    return streamController.stream;
  }


}
