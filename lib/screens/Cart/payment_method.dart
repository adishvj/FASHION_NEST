import 'package:flutter/material.dart';

import '../../constants.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  State<PaymentMethod> createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod> {
  String? _selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  TextEditingController upiController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  void _handleAddPayment() {
    if (_selectedPaymentMethod != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if (_selectedPaymentMethod == 'UPI') {
            return AlertDialog(
              backgroundColor: Colors.grey[300],
              title: const Text(
                'Enter UPI Details',
                style: TextStyle(fontFamily: "Airbnb"),
              ),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: upiController,
                  decoration: InputDecoration(
                      labelText: 'Enter UPI ID',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      )),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'This field is required'
                        : null;
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          } else if (_selectedPaymentMethod == 'Card') {
            return AlertDialog(
              backgroundColor: Colors.grey[300],
              title: const Text(
                'Enter Card Details',
                style: TextStyle(fontFamily: "Airbnb"),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: cardNumberController,
                      decoration: InputDecoration(
                          labelText: 'Card Number',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: expiryDateController,
                      decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: cvvController,
                      decoration: InputDecoration(
                          labelText: 'CVV',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColors)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColors))),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          } else {
            return AlertDialog(
              backgroundColor: Colors.grey[300],
              title: Text(
                'Payment Method: $_selectedPaymentMethod',
                style: TextStyle(fontFamily: "Airbnb"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: primaryColors,
            content: Text('Please select a payment method')),
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSnackBar() {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: primaryColors,
        content: Text('Message sent Succesfully'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            color: primaryColors,
            child: Stack(children: [
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 99,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select Payment Method:',
                            style:
                                TextStyle(color: primaryColors, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Column(
                              children: [
                                RadioListTile<String>(
                                  title: const Text('UPI'),
                                  value: 'UPI',
                                  activeColor: primaryColors,
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: _handleRadioValueChange,
                                ),
                                RadioListTile<String>(
                                  title: const Text('Cash on Delivery'),
                                  activeColor: primaryColors,
                                  value: 'Cash on Delivery',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: _handleRadioValueChange,
                                ),
                                RadioListTile<String>(
                                  title: const Text('Card'),
                                  value: 'Card',
                                  activeColor: primaryColors,
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: _handleRadioValueChange,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Container(
                              height: 60,
                              width: 130,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColors,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  _handleAddPayment();
                                },
                                child: const Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: 50,
                left: 15,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 90,
                child: Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Airbnb",
                    color: Colors.white70,
                  ),
                ),
              ),
            ])));
  }
}
