import 'dart:io';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:quick_car/constants/strings.dart';
import '../data_class/car_data.dart';
import '../data_class/reservation.dart';
import 'package:stripe_payment/stripe_payment.dart';

class UserState extends ChangeNotifier {
  bool _isLoggedIn = false;
  File _carLicensePhoto;
  CreditCard _creditCard;
  String _currency;
  bool isLoggedIn() => _isLoggedIn;
  File getCarLicensePhoto() => _carLicensePhoto;
  CreditCard getCreditCard() => _creditCard;
  String getCurrency() => _currency != null ? _currency : Strings.USD;

  String _token;
  String _firstName;
  String _lastName;
  String _email;
  int _id;
  int getId () => _id;
  String getEmail () => _email;
  String getFirstName() => _firstName;
  String getLastName() => _lastName;
  String getToken() => _token;
  List<CarData> _carsAsRenterOut = [];
  List<Reservation> _reservationsAsBorrower = [];
  List<CarData> getMyCars() => _carsAsRenterOut;
  List<Reservation> getMyReservation() => _reservationsAsBorrower;
  void setToken(String token) {
    _token = token;
  }
  void addUserCar(CarData cd) {
    _carsAsRenterOut.add(cd);
    notifyListeners();
  }
  void setUserCars(List<CarData> carsList) {
    for (int i = 0; i < carsList.length; i++) {
      print(carsList[i].id);
    }
    _carsAsRenterOut = carsList;
  }
  void addUserReservation(Reservation r) {
    _reservationsAsBorrower.add(r);
    notifyListeners();
  }
  void setReservationActive(Reservation r) {
    r.isActive = true;
    notifyListeners();
  }
  void removeReservation(Reservation r) {
    _reservationsAsBorrower.remove(r);
    notifyListeners();
  }
  void deleteCreditCard() {
    _creditCard = null;
    notifyListeners();
  }
  void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
  void setFirstName(String fn) {
    _firstName = fn;
    notifyListeners();
  }
  void setLastName(String ln){
    _lastName = ln;
    notifyListeners();
  }
  void addCreditCard(CreditCard cd) {
    _creditCard = cd;
    notifyListeners();
  }
  void setLoginSetup(int id, String fn, String ln, String em, bool isLoggedIn, File carLicense, String currency) {
    _id = id;
    _firstName = fn;
    _lastName = ln;
    _email = em;
    _isLoggedIn = isLoggedIn;
    _carLicensePhoto = carLicense;
    _currency = currency;
    notifyListeners();
  }
  void setCarLicensePhoto(File clp) {
    print(clp.path);
    _carLicensePhoto = clp;
    notifyListeners();
  }
  void removeCarToRentOut(int id) {
    _carsAsRenterOut.removeWhere((element) => element.id == id);
  }
  void setCurrency(String currencyCode) {
    _currency = currencyCode;
  }
}