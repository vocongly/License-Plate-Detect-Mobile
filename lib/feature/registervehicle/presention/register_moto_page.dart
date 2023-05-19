import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/core/theme/app_data.dart';
import 'package:license_plate_detect/feature/home/presention/HomePage.dart';
import 'package:license_plate_detect/feature/pay/pay_page.dart';
import 'package:license_plate_detect/feature/registervehicle/widget/pickeddate.dart';
import 'package:license_plate_detect/services/auth/auth.dart';

import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';
import 'package:license_plate_detect/ultis/loading/customloading.dart';
import 'package:license_plate_detect/ultis/toast/customtoast.dart';

class RegisterVehiclePage extends StatefulWidget {
  const RegisterVehiclePage({super.key});

  @override
  State<RegisterVehiclePage> createState() => _RegisterVehiclePageState();
}

class _RegisterVehiclePageState extends State<RegisterVehiclePage> {
  TextEditingController plateController = TextEditingController();

  List<Map> vehicletypes = [
    {'id': '1', 'name': '1 tuần', 'image': AppData.icMotobike},
    {'id': '2', 'name': '1 tháng', 'image': AppData.icCar},
  ];

  String? _selected;
  String? valueChoose;
  String? vehicletype;
  String? newValue;

  List listItem = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10'];

  var isDeviceConnected = false;
  bool isAlertSet = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F7),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Đăng ký xe máy',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: 24,
            right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              width: size.width,
              height: 130,
              fit: BoxFit.contain,
              image: const AssetImage(AppData.imgMoto),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                       Align(
                        alignment: Alignment.topLeft,
                         child: Padding(
                                         padding: const EdgeInsets.symmetric(vertical: 10),
                                         child: Text(
                                           'Đăng ký',
                                           style: Theme.of(context).textTheme.titleLarge,
                                         ),
                                       ),
                       ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppData.icPlate,
                            width: 32,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          
                          Expanded(
                            child: TextFormField(
                              controller: plateController,
                              decoration: const InputDecoration(
                                  labelText: 'Nhập biển số xe'),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'[1-9]{1}[0-9]{1}[A-Z]{1,2}[1-9]{0,1}[-]{1}[0-9]{4,5}')
                                        .hasMatch(value)) {
                                  return 'Vui lòng nhập đúng biển số';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const PickedDate()
              ],
            ),
            SizedBox(
              width: size.width,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const PayPage();
                    },
                  ));
                },
                // onPressed: () async {
                //   bool checkConnection = await checkInternet.getConnectivity(
                //       isDeviceConnected, isAlertSet);
                //   if (!checkConnection) {
                //     checkInternet.showDialogBox(
                //         context, isDeviceConnected, isAlertSet);
                //     setState(() {
                //       isAlertSet = true;
                //     });
                //   } else {
                //     if (formKey.currentState!.validate()) {
                //       if (vehicletype == null) {
                //         CustomToast.presentWarningToast(
                //             context, 'Vui lòng chọn loại xe!');
                //       } else {
                //         CustomLoading.loadingtext(
                //             context, 'Đang đăng ký tài khoản');
                //         CheckAndDetail cks = await Authenticate.registerVehicle(
                //             plateController.text, vehicletype!);
                //         if (cks.check == true) {
                //           CustomLoading.dismisloading(context);
                //           CustomToast.presentSuccessToast(
                //               context, 'Đăng ký xe thành công!');
                //           Navigator.push(context,
                //               MaterialPageRoute(builder: (context) {
                //             return const MyHomePage();
                //           }));
                //         } else if (cks.check == false) {
                //           CustomLoading.dismisloading(context);
                //           CustomToast.presentErrorToast(
                //               context, '${cks.detail}');
                //         }
                //       }
                //     }
                //   }
                // },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: const Text(
                  'Đăng ký xe',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
