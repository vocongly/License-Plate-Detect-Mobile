import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickedDate extends StatefulWidget {
  const PickedDate({super.key});

  @override
  State<PickedDate> createState() => _PickedDateState();
  
}

class _PickedDateState extends State<PickedDate> {

  final TextEditingController _date = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _date,
                      decoration:
                          const InputDecoration(labelText: 'Ngày gửi'),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(2101));

                              if (pickeddate != null) {
                                setState(() {
                                  _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                                });
                              }
                          },

                    ),
                  ),
                ]);
  }
}