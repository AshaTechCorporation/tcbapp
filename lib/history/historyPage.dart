import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/icons/logo MOPH.png',
                  scale: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28, top: 10, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: kBackgroundColor2,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: DropdownSearch<String>(
                    selectedItem: selectedValue,
                    items: items,
                    itemAsString: (item) => item,
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      constraints: BoxConstraints(maxHeight: 450),
                      fit: FlexFit.loose,
                      menuProps: MenuProps(
                        backgroundColor: Colors.white,
                      ),
                      itemBuilder: (context, item, isSelected) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onChanged: (String? va) {
                      setState(() {
                        selectedValue = va;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                      dropdownSearchDecoration: InputDecoration(
                        hintText: 'เลือกผู้รับบุคลากรภายใน',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                        border: InputBorder.none,
                        suffixIconColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_upward_rounded, size: size.height * 0.03, color: kBackgroundColor2),
                    ),
                  ),
                ],
              )
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
