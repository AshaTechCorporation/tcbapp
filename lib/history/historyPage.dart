import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> items = [
    'โรงพยาบาล',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor3,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ประวัติการรักษา', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            CircleAvatar(),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width * 0.6,
                  height: size.height * 0.08,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'เลือกประเภทการใช้งาน',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IBMPlexSansThai',
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedValue,
                      onChanged: (String? va) {
                        setState(
                          () {
                            selectedValue = va;
                          },
                        );
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: kBackgroundColor2,
                            width: 2,
                          ),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: kBackgroundColor2,
                            width: 2,
                          ),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: size.height * 0.08,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                final item = cardItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: CardItem(
                    date: item['date'] ?? '',
                    hospital: item['hospital'] ?? '',
                    diagnosis: item['diagnosis'] ?? '',
                    size: size,
                    rectum: item['rectum'] ?? '',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
