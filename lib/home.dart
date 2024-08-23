import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_payment/contants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'PKR',
    'AED',
    'GBP',
  ];
  String selectedCurrency = 'USD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/images/image.png'),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Implementing Stripe payment method",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReuseableTextField(
                          title: 'Donation amount',
                          formkey: formkey,
                          controller: amountController,
                          hint: 'Amount',
                          isNumber: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownMenu<String>(
                        inputDecorationTheme: InputDecorationTheme(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 2),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        initialSelection: currencyList.first,
                        onSelected: (String? value) {
                          setState(() {
                            selectedCurrency = value!;
                          });
                        },
                        dropdownMenuEntries:
                            currencyList.map<DropdownMenuEntry<String>>(
                          (String value) {
                            return DropdownMenuEntry(
                                value: value, label: value);
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReuseableTextField(
                    title: "Name",
                    formkey: formkey1,
                    controller: nameController,
                    hint: 'Ex. Inaam Ul Haq',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReuseableTextField(
                    title: "Address",
                    formkey: formkey2,
                    controller: addressController,
                    hint: 'Ex. 123 Main St.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReuseableTextField(
                          title: "City",
                          formkey: formkey3,
                          controller: cityController,
                          hint: 'Ex. Lahore',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ReuseableTextField(
                          title: "State",
                          formkey: formkey4,
                          controller: stateController,
                          hint: 'Ex. Punjab',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ReuseableTextField(
                          title: "Country",
                          formkey: formkey3,
                          controller: countryController,
                          hint: 'Ex. Pakistan',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ReuseableTextField(
                          title: "Pincode",
                          formkey: formkey4,
                          controller: pincodeController,
                          hint: 'Ex. 54000',
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.orange),
                        onPressed: () async {},
                        child: const Text(
                          'Proceed to Pay',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
