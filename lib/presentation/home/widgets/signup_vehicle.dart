import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';

class SignunVehicle extends StatelessWidget {
  final VoidCallback onClicked;

  const SignunVehicle({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.primaryColor),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đăng ký xe',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.white,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: onClicked,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.white),
                            child: Text('Xe hơi',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColor.primaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: onClicked,
                          child: Container(
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
