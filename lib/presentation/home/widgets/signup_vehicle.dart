import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/registervehicle/presention/register_car_page.dart';

class SignunVehicle extends StatelessWidget {
  final VoidCallback onClicked;

  const SignunVehicle({super.key, required this.onClicked});

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
                    'Đăng ký xe',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.white,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 110,
                          height: 50,
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.white),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterVehicleCar();
                                },
                              )
                              );
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
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
