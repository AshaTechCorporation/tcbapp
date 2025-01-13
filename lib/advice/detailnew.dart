import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/WidgetHub/waterMark.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class Detailnew extends StatefulWidget {
  Detailnew({super.key, required this.size, required this.detail, required this.title, required this.id});

  String? detail;
  String? title;
  int id;
  final Size size;
  // int id;
  @override
  State<Detailnew> createState() => _DetailnewState();
}

class _DetailnewState extends State<Detailnew> {
  Future getapi() async {
    try {
      LoadingDialog.open(context);
      await context.read<ProjectController>().getadvicebyid(widget.id);
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
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return RegisterPage();
            //     },
            //   ),
            // );
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getNews();
      await getapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBackgroundColor3,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('รายละเอียดเพิ่มเติม', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/icons/Cancer_AnyWhere.png',
                    scale: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Consumer<ProjectController>(builder: (context, controller, child) {
          final advice = controller.advice;
          return Watermark(
            backgroundImage: const AssetImage('assets/icons/logo MOPH.png'),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.85,
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: textColor2.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // Center(
                            //   child: SizedBox(
                            //     height: size.height * 0.3,
                            //     width: double.infinity,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child:
                            //           // Image.network(
                            //           //   "${widget.image}",
                            //           //   height: size.height * 0.12,
                            //           //   width: size.width * 0.25,
                            //           //   fit: BoxFit.cover,
                            //           //   errorBuilder: (context, error, stackTrace) {
                            //           //     return Image.asset(
                            //           //         'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'); // แสดงภาพสำรอง
                            //           //   },
                            //           // ),
                            //           Image.asset(
                            //         '${widget.image}',
                            //         errorBuilder: (context, error, stackTrace) {
                            //           return Image.asset(
                            //             'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Text(
                            //   '${widget.title}',
                            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            // ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Html(data: advice?.description

                                  // overflow: TextOverflow.ellipsis,

                                  // '${widget.detail}',
                                  // style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  // maxLines: 2,
                                  // overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        })

        // },
        // ),
        );
  }
}
