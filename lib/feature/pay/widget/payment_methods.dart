

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_data.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}
String? pay;
class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: RadioListTile(
                          secondary: Image.asset(AppData.icMomo),
                          title:
                          const Text('Momo'),
                          value: 'momo', 
                          groupValue: pay, 
                          onChanged: (newValue){
                            setState(() {
                              pay = newValue.toString();
                            });
                          }
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: RadioListTile(
                          secondary: const Icon(Icons.payment),
                          title:
                          const Text('Thẻ ngân hàng'),
                          value: 'Ngân hàng', 
                          groupValue: pay, 
                          onChanged: (newValue){
                            setState(() {
                              pay = newValue.toString();
                            });
                          }
                          )
                      ),
      ],
    );
  }
}