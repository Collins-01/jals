import 'package:flutter/material.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class PasswordViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController passwordController = TextEditingController();

  confirmPassword() async {
    _navigationService.navigateToReplace(AccountInfoViewRoute);
  }
}