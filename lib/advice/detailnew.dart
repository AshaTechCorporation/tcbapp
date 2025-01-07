import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/WidgetHub/waterMark.dart';
import 'package:tcbapp/constants.dart';

class Detailnew extends StatefulWidget {
  Detailnew({super.key, required this.size, required this.image, required this.detail, required this.title});
  String? image;
  String? detail;
  String? title;
  final Size size;
  // int id;
  @override
  State<Detailnew> createState() => _DetailnewState();
}

class _DetailnewState extends State<Detailnew> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getNews();
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
        body: Watermark(
          backgroundImage: const AssetImage('assets/icons/logo MOPH.png'),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: size.height * 0.3,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          // Image.network(
                          //   "${widget.image}",
                          //   height: size.height * 0.12,
                          //   width: size.width * 0.25,
                          //   fit: BoxFit.cover,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return Image.asset(
                          //         'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'); // แสดงภาพสำรอง
                          //   },
                          // ),
                          Image.asset(
                        '${widget.image}',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                      child: Column(
                        children: [
                          Text(
                            '${widget.title}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.detail}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // },
        // ),
        );
  }
}
