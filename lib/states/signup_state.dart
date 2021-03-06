import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../api/sign_up_api.dart';
import 'package:stripe_payment/stripe_payment.dart';

class SignUpState {
  final int id;
  final SignUpApi api;
  final bool formCompleted;
  final File carLicense;
  final bool licenseCompleted;
  final CreditCard creditCard;

  const SignUpState({this. id, this.api, this.formCompleted, this.carLicense, this.licenseCompleted, this.creditCard});

  SignUpState copyWith({bool formCompleted, File carLicense, bool licenseCompleted,
    CreditCard creditCard, int id}) {
    return SignUpState(
      formCompleted: formCompleted ?? this.formCompleted,
      carLicense: carLicense ?? this.carLicense,
      licenseCompleted: licenseCompleted ?? this.licenseCompleted,
      creditCard: creditCard ?? this.creditCard,
      id: id ?? this.id
    );
  }
}