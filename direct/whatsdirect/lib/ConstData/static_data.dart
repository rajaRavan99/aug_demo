import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isHowToUseScreen = true;
bool isGetMsg = true;
RxBool isTemp = false.obs;
TextEditingController addMsgController = TextEditingController();
TextEditingController addPhoneController = TextEditingController();
Directory iosDirectory = Directory('');
