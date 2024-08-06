import 'package:ecommerce_mobile_app/screens/Cart/payment_method.dart';
import 'package:flutter/material.dart';

import '../nav_bar_screen.dart';

class CheckoutPage extends StatefulWidget {
  final num total;

  CheckoutPage({required this.total});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String contactName = '';
  String address = '';
  String paymentMethod = 'Select Payment Method';

  TextEditingController contactNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    contactNameController.text = contactName;
    addressController.text = address;
  }

  void updateContactInfo(String newName) {
    setState(() {
      contactName = newName;
      contactNameController.text = newName;
    });
  }

  void updateAddress(String newAddress) {
    setState(() {
      address = newAddress;
      addressController.text = newAddress;
    });
  }

  void updatePaymentMethod(String newMethod) {
    setState(() {
      paymentMethod = newMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Text(
              'Checkout',
              style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Contact Information:',
                  style: TextStyle(fontFamily: "Airbnb"),
                ),
                ListTile(
                  title: TextFormField(
                    controller: contactNameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Edit Name'),
                              content: TextFormField(
                                controller: contactNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter new name',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateContactInfo(
                                          contactNameController.text);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  title: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Edit Address'),
                              content: TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  hintText: 'Enter new address',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an address';
                                  }
                                  return null;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateAddress(addressController.text);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Payment Method:',
                  style: TextStyle(fontFamily: "Airbnb"),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.yellow[900],
                      ),
                      onPressed: () async {
                        final selectedMethod = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ),
                        );
                        if (selectedMethod != null) {
                          updatePaymentMethod(selectedMethod);
                        }
                      },
                      child: Text(paymentMethod),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Order Summary:',
                  style: TextStyle(fontFamily: "Airbnb"),
                ),
                ListTile(
                  title: Text('Subtotal: \$${widget.total.toStringAsFixed(2)}'),
                ),
                ListTile(
                  title: Text('Shipping Cost: \$40'),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Total: \$${(widget.total + 40).toStringAsFixed(2)}',
                    style: TextStyle(fontFamily: "Airbnb"),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success'),
                          content: Image.asset("images/Frame 271.png"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBar(),
                                    ));
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
