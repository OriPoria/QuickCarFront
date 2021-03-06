import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:quick_car/states/signup_state.dart';
import 'package:quick_car/states/user_state.dart';
import 'package:quick_car/view/widgets/buttons.dart';
import 'package:quick_car/view/widgets/messages.dart';
import 'package:stripe_payment/stripe_payment.dart';

class UploadCreditCard extends StatefulWidget {
  bool addSkipButton;
  UserState state;
  UploadCreditCard({bool asb, UserState st}) {
    addSkipButton = asb;
    state = st;
  }
  @override
  _UploadCreditCardState createState() => _UploadCreditCardState();
}

class _UploadCreditCardState extends State<UploadCreditCard> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isValid = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _continuePressed() {
    // got from sign-up process
    if (widget.addSkipButton) {
      if (isValid) {
        CreditCard creditCard = CreditCard(number: cardNumber,
            name: cardHolderName,expMonth: 1, expYear:2024, cvc: cvvCode);
        context.flow<SignUpState>().complete((signupState) {
          return signupState.copyWith(creditCard: creditCard);
        });
      }
      context.flow<SignUpState>().complete((signupState) {
        return signupState;
      });
      // got from profile
    } else if (widget.state != null) {
      if (isValid) {
        String expStr = expiryDate;
        CreditCard creditCard = CreditCard(number: cardNumber,
            name: cardHolderName,expMonth: int.parse(expStr.split("/")[0]),
            expYear:int.parse(expStr.split("/")[1]), cvc: cvvCode);
        widget.state.addCreditCard(creditCard);
        Navigator.pop(context);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Credit Card Details"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: Colors.lightBlue,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onPressed: () {
                          isValid = true;
                          _continuePressed();
                        },
                      ),
                      addSkipButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget addSkipButton() {
    if (widget.addSkipButton) {
      return skipButton(onPressed: () => _continuePressed());
    } else return SizedBox(
      height: 5,
    );
  }
}
