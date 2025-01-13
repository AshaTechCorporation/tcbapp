import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:tcbapp/advice/detailnew.dart';
import 'package:tcbapp/constants.dart';

class Cardnews extends StatefulWidget {
  final Size size;
  int? id;
  String? detail;
  String? title;
  Cardnews({super.key, required this.size, required this.detail, required this.title, required this.id});

  @override
  State<Cardnews> createState() => _CardnewsState();
}

class _CardnewsState extends State<Cardnews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.size.height * 0.01),
      child: Container(
        width: widget.size.width * 0.98,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: textColor2.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           height: widget.size.height * 0.02,
            //         ),
            //         // Image.network(
            //         //   '${widget.image}',
            //         //   errorBuilder: (context, error, stackTrace) {
            //         //     return Image.asset(
            //         //       'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
            //         //     );
            //         //   },
            //         // ),
            //         Image.asset(
            //           '${widget.image}',
            //           errorBuilder: (context, error, stackTrace) {
            //             return Image.asset(
            //               'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
            //             );
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           '${widget.title}',
                  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  widget.detail != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data: widget.detail!.length > 300 ? "${widget.detail!.substring(0, 300)} ..." : widget.detail,
                          ),
                        )
                      : SizedBox.shrink(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detailnew(
                              size: widget.size,
                              detail: widget.detail ?? '',
                              title: widget.title,
                              id: widget.id ?? 0,
                            ),
                          ),
                        );
                        // try {
                        //   LoadingDialog.open(context);

                        //   await context.read<ProjectController>().getadvicebyid(widget.id!);
                        //   if (!mounted) return;
                        //   LoadingDialog.close(context);
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(
                        //   //     builder: (context) => Detailnew(
                        //   //       size: widget.size,
                        //   //       detail: widget.detail,
                        //   //       title: widget.title,
                        //   //     ),
                        //   //   ),
                        //   // );
                        // } on ClientException catch (e) {
                        //   if (!mounted) return;
                        //   LoadingDialog.close(context);
                        //   showDialog(
                        //     context: context,
                        //     builder: (context) => Dialogyes(
                        //       title: 'แจ้งเตือน',
                        //       description: '$e',
                        //       pressYes: () {
                        //         Navigator.pop(context, true);
                        //       },
                        //       bottomNameYes: 'ตกลง',
                        //     ),
                        //   );
                        // } on ApiException catch (e) {
                        //   if (!mounted) return;
                        //   LoadingDialog.close(context);
                        //   showDialog(
                        //     context: context,
                        //     builder: (context) => Dialogyes(
                        //       title: 'แจ้งเตือน',
                        //       description: '$e',
                        //       pressYes: () {
                        //         Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) {
                        //               return RegisterPage();
                        //             },
                        //           ),
                        //         );
                        //       },
                        //       bottomNameYes: 'ตกลง',
                        //     ),
                        //   );
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: widget.size.height * 0.04,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 221, 215, 215),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('อ่านรายละเอียดเพิ่มเติม', style: TextStyle(fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_forward, size: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
