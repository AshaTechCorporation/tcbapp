import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/WidgetHub/waterMark.dart';
import 'package:tcbapp/advice/widget/cardNews.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String cid = '';

  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final cids = prefs.getString('cid');
    setState(() {
      cid = cids ?? '';
    });
  }

  Future getapi() async {
    try {
      LoadingDialog.open(context);
      await context.read<ProjectController>().getadvice(cid);
      // await context.read<ProjectController>().getlisTreatmenthistory(cid);
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
      LoadingDialog.close(context);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrefs();
      await getapi();
    });
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
            Text('คำแนะนำการปฏิบัติตัว', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/icons/Cancer_AnyWhere.png',
                      scale: 10,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/icons/1Artboard 7@4x.png',
                    scale: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<ProjectController>(
        builder: (context, controller, child) {
          final advicdes = controller.advicdes;
          return Watermark(
            backgroundImage: const AssetImage('assets/icons/logo MOPH.png'),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  advicdes!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: size.height * 0.8,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              // controller: _scrollController,
                              itemCount: advicdes?.length,
                              itemBuilder: (context, index) {
                                final items = advicdes?[index];
                                return Cardnews(
                                  size: size,
                                  detail: items?.description ?? '',
                                  title: 'สถาบันมะเร็งแห่งชาติ',
                                  id: items!.id,
                                );
                              },
                            ),
                          ),
                        )
                      : Center(child: Text('ขนะนี้ไม่มีรายการคำแนะนำ'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
