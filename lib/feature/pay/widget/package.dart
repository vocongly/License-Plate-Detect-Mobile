import 'package:flutter/material.dart';

class Package extends StatefulWidget {
  const Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}


String? money;

class _PackageState extends State<Package> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: RadioListTile(
                title: const Text('30.000đ/1 tuần',style: TextStyle(fontWeight: FontWeight.w500)),
                value: 'Tuần',
                groupValue: money,
                onChanged: (newValue) {
                  setState(() {
                    money = newValue.toString();
                  });
                })),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: RadioListTile(
                title: const Text('100.000/1 tháng', style: TextStyle(fontWeight: FontWeight.w500),),
                value: 'Tháng',
                groupValue: money,
                onChanged: (newValue) {
                  setState(() {
                    money = newValue.toString();
                  });
                })),
      ],
    );
  }
}
