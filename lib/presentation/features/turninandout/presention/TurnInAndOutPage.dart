
// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:license_plate_detect/core/models/Region.dart';
import 'package:license_plate_detect/core/models/vehicle.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/features/turninandout/widget/confirm_button.dart';
import 'package:license_plate_detect/presentation/features/turninandout/widget/info_vehicle_v2.dart';
import 'package:license_plate_detect/presentation/widget/build_button.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:license_plate_detect/ultis/loading/LoadingWidget.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';

class TurnInAndOutPage extends StatefulWidget {
  const TurnInAndOutPage({super.key});

  @override
  State<TurnInAndOutPage> createState() => _TurnInAndOutPageState();
}

File? image;

class _TurnInAndOutPageState extends State<TurnInAndOutPage> {
  
  List<Region> regions = [];

  List<String> turns = ['in', 'out'];

  String? turn = 'in';

  String? selectedRegion;
  String? idRegion;

  List<Vehicle> vehicles = [];

  bool loading = true;

  Future getRegion() async {
    await AppAPI.GetRegion().then((value) => {
          regions = value,
          selectedRegion = regions[0].region,
          idRegion = regions[0].sId
        });
  }

  Future pickImage(ImageSource source) async {
    try {
      final imagepost = await ImagePicker().pickImage(source: source);
      if (imagepost == null) return;
      final imageTemporary = File(imagepost.path);

      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  var isDeviceConnected = false;
  bool isAlertSet = false;

  void checkConnection() async {
    bool checkConnection =
        await checkInternet.getConnectivity(isDeviceConnected, isAlertSet);
    if (!checkConnection) {
      checkInternet.showDialogBox(context, isDeviceConnected, isAlertSet);
      setState(
        () => isAlertSet = true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    getRegion().whenComplete(() => {
          setState(
            () {
              loading = false;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingWidget()
        : Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(title: const Text('Quản lý phương tiện')),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: image != null
                            ? Image.file(
                                image!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )
                            : Text(
                              'Chưa có ảnh phương tiện',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 18),
                            ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildButton(
                          title: 'Pick Gallery',
                          icon: Icons.image_outlined,
                          onClicked: () => pickImage(ImageSource.gallery)),
                      const SizedBox(
                        height: 24,
                      ),
                      BuildButton(
                          title: 'Pick Camera',
                          icon: Icons.camera_alt_outlined,
                          onClicked: () => pickImage(ImageSource.camera)),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Khu vực: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.only(left: 8),
                                child: DropdownButton(
                                  items: regions
                                      .map((value) => DropdownMenuItem<String>(
                                          value: value.region,
                                          child: Text(
                                            value.region!,
                                            style: const TextStyle(fontSize: 15),
                                          )))
                                      .toList(),
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  onChanged: (item) => setState(() {
                                    selectedRegion = item as String?;
                                    for (var region in regions) {
                                      if (region.region == selectedRegion) {
                                        idRegion = region.sId;
                                      }
                                    }
                                  }),
                                  value: selectedRegion,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Lượt: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.only(left: 8),
                                child: DropdownButton(
                                  items: turns
                                      .map((value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,style: const TextStyle(fontSize: 15),
                                          )))
                                      .toList(),
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  onChanged: (item) => setState(() {
                                    turn = item as String?;
                                  }),
                                  value: turn,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ConfirmButton(
                          onClicked: () async {
                            List<Vehicle> list = await AppAPI.TurnInAndOut(
                                image!, idRegion!, turn!);
                            setState(() {
                              vehicles = list;
                            });
                          },
                          title: 'Xác nhận'),
                      image !=null ? InfoVehicleV2(vehicles: vehicles, image: image!) : Container()
                    ],
                  ),
                ),
              ),
            ));
  }
}
