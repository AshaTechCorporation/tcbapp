import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';
import 'package:tcbapp/model/medicalHistory.dart';
import 'package:tcbapp/model/visitedHospitals.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  VisitedHospitals? selectedValue;
  final ScrollController _scrollController = ScrollController();

  String cid = '';

  @override
  void dispose() {
    // อย่าลืม dispose เมื่อไม่ใช้
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrefs();
      await getapi();
    });
  }

  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final cids = prefs.getString('cid');
    setState(() {
      cid = cids ?? '';
    });
  }

  Future<String> formatDiagnosisDate(int index) async {
    final medicalHistorys = context.read<ProjectController>().medicalHistorys;

    try {
      // ตรวจสอบว่าค่า diagnosis_date มีหรือไม่
      final diagnosisDate = medicalHistorys?[index].diagnosis_date;

      if (diagnosisDate == null) {
        return "ไม่มีข้อมูลวันที่";
      }

      // แปลง String เป็น DateTime
      DateTime dateTime = DateTime.parse(diagnosisDate);

      // เพิ่มค่าปีเป็นปี พ.ศ.
      int buddhistYear = dateTime.year + 543;

      // แปลงวันที่เป็นรูปแบบ "วัน เดือน ปี พ.ศ."
      String formattedDate = '${DateFormat("d MMMM").format(dateTime)} $buddhistYear';
      return formattedDate;
    } catch (e) {
      return "รูปแบบวันที่ไม่ถูกต้อง";
    }
  }

  Future getapi() async {
    try {
      LoadingDialog.open(context);
      await context.read<ProjectController>().getMedicalHistorys(cid);
      await context.read<ProjectController>().getlisTreatmenthistory(cid);
      if (!mounted) return;
      LoadingDialog.close(context);
    } on ClientException catch (e) {
      if (!mounted) return;
      LoadingDialog.close(context);
      showDialog(
        context: context,
        builder: (context) => Dialogyes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            Navigator.pop(context, true);
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      // LoadingDialog.close(context);
      showDialog(
        context: context,
        builder: (context) => Dialogyes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterPage();
                },
              ),
            );
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor3,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Consumer<ProjectController>(
        builder: (context, controller, child) {
          final medicalHistorys = controller.medicalHistorys;
          final treatmenthistory = controller.treatmentHistorys;
          return Column(
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
                          color: kBackgroundColor,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: DropdownSearch<VisitedHospitals>(
                        selectedItem: selectedValue,
                        items: treatmenthistory!,
                        itemAsString: (item) => item.hospital_name ?? '',
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
                                  item.hospital_name ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onChanged: (VisitedHospitals? va) {
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cardItems = cardItems.reversed.toList();
                      });
                    },
                    child: Stack(
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
                            child: Icon(Icons.arrow_upward_rounded, size: size.height * 0.03, color: kBackgroundColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: medicalHistorys?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = medicalHistorys?[index];

                    // ตรวจสอบและแปลง diagnosis_date เป็นวันเดือนปีแบบ พ.ศ.
                    String formattedDate = '-';
                    if (item?.diagnosis_date != null) {
                      try {
                        DateTime dateTime = DateTime.parse(item!.diagnosis_date!);
                        int buddhistYear = dateTime.year + 543;
                        formattedDate = '${DateFormat("d MMMM").format(dateTime)} $buddhistYear';
                      } catch (e) {
                        formattedDate = "รูปแบบวันที่ไม่ถูกต้อง";
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: CardItem(
                        date: formattedDate, // ใช้วันที่ที่แปลงแล้ว
                        hospital: item?.hospital_name ?? '',
                        diagnosis: item?.icd10_text ?? '',
                        size: size,
                        medicalHistorys: item?.treatments,
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
