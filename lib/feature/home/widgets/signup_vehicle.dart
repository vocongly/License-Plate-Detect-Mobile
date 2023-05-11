import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/feature/registervehicle/presention/register_vehicle_page.dart';

import '../../registervehicle/presention/register_vehicle_car.dart';



class SignunVehicle extends StatelessWidget {
  final VoidCallback onClicked;

  const SignunVehicle({Key? key, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.primaryColor),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Đăng ký xe!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.white,
                        ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 45,
                         decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.white),
                          child: ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                               
                                
                                ),
                            
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const registerVehivleCar();
                                },
                                
                              ));
                            },
                            child: Text('Xe hơi',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColor.primaryColor)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onClicked,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColor.white),
                          child: Text('Xe máy',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColor.primaryColor)),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
