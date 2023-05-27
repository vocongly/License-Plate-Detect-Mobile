import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_data.dart';

class PaymentMethods extends StatefulWidget {
  
  const PaymentMethods({
    super.key, 
  });

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
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Momo",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Image.asset(AppData.icMomo),
                    ]),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Tên ví MoMo:",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                    Text(
                      "NVA",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Số điện thoại:",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                    Text(
                      "0912345678",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // const SizedBox(height: 10,),

        // Container(
        //   height: 120,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       border: Border.all(

        //       ),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        //     child: Column(
        //       children: [
        //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           const Text(
        //             "Chuyển khoản",
        //             style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black),
        //           ),
        //           Image.asset(AppData.icMbbank),

        //         ]
        //         ),
        //         const SizedBox(
        //           height: 7),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: const [
        //             Text(
        //                 "Ngân hàng:",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.grey),
        //             ),
        //             Text(
        //                 "MB Bank",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.black),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 5),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: const [
        //             Text(
        //                 "Người thụ hưởng:",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.grey),
        //             ),
        //             Text(
        //                 "Nguyễn Văn A",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.black),
        //             ),
        //           ],
        //         ),

        //          const SizedBox(
        //           height: 5),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: const [
        //             Text(
        //                 "Số tài khoản:",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.grey),
        //             ),
        //             Text(
        //                 "0912345678",
        //                 style: TextStyle(
        //                     fontSize: 13,
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.black),
        //             ),
        //           ],
        //         ),

        //       ],

        //     ),
        //   ),
        // )
      ],
    );
  }
}
