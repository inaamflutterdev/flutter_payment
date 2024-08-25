// ignore_for_file: avoid_print, use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_payment/contants.dart';
import 'package:flutter_payment/payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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
  bool hasDonated = false;

  Future<void> initPaymentSheet() async {
    try {
      final data = await createPaymentIntent(
        // convert string to double
        amount: (int.parse(amountController.text) * 100).toString(),
        currency: selectedCurrency,
        name: nameController.text,
        address: addressController.text,
        pin: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
      );

      // Ensure that all required fields from the response are not null
      if (data == null) {
        throw Exception("Payment initialization failed: no data received.");
      }

      final clientSecret = data['client_secret'];
      final ephemeralKey = data['ephemeralKey'];
      final customerId = data['id'];

      if (clientSecret == null || ephemeralKey == null || customerId == null) {
        throw Exception("Payment initialization failed due to missing data.");
      }

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: clientSecret,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customerId,
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                            formkey: formkey5,
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
                            formkey: formkey6,
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
                          onPressed: () async {
                            if (formkey.currentState!.validate() &&
                                formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate() &&
                                formkey3.currentState!.validate() &&
                                formkey4.currentState!.validate() &&
                                formkey5.currentState!.validate() &&
                                formkey6.currentState!.validate()) {
                              await initPaymentSheet();
                              try {
                                await Stripe.instance.presentPaymentSheet();

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Payment Done",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                ));

                                setState(() {
                                  hasDonated = true;
                                });
                                nameController.clear();
                                addressController.clear();
                                cityController.clear();
                                stateController.clear();
                                countryController.clear();
                                pincodeController.clear();
                              } catch (e) {
                                print("payment sheet failed");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Payment Failed",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ));
                              }
                            }
                          },
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
      ),
    );
  }
}
