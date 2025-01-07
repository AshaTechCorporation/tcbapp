import 'package:flutter/material.dart';
import 'package:tcbapp/advice/detailnew.dart';
import 'package:tcbapp/constants.dart';

class Cardnews extends StatefulWidget {
  final Size size;
  String? image;
  String? detail;
  String? title;
  Cardnews({super.key, required this.size, required this.image, required this.detail, required this.title});

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
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: widget.size.height * 0.02,
                    ),
                    // Image.network(
                    //   '${widget.image}',
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Image.asset(
                    //       'assets/images/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                    //     );
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.title}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.detail}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailnew(
                                      size: widget.size,
                                      image: widget.image,
                                      detail: widget.detail,
                                      title: widget.title,
                                    )));
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
