import 'package:flutter/material.dart';
import 'package:tcbapp/advice/widget/cardNews.dart';
import 'package:tcbapp/constants.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            cardNews.isNotEmpty
                ? SizedBox(
                    height: size.height * 0.8,
                    child: ListView.builder(
                        // controller: _scrollController,
                        itemCount: cardNews.length,
                        itemBuilder: (context, index) {
                          final items = cardNews[index];
                          return Cardnews(
                            size: size,
                            image: '',
                            detail: '${items['detail']}',
                            title: '${items['title']}',
                          );
                        }),
                  )
                : Center(child: Text('ขนะนี้ไม่มีรายการคำแนะนำ'))
          ],
        ),
      ),
    );
  }
}
