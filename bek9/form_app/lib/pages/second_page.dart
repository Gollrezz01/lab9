import 'package:flutter/material.dart';
import 'package:form_app/constants/text_style_values.dart';
import 'package:like_button/like_button.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List products = ['Привет', 'Hello', 'Bye', 'ByeBye'];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text('${products[index]}', style: AppTextStyles.px12blue,),
                trailing: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: LikeButton(
                    size: 20,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 20,
                      );
                    },
                    likeCount: 0,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
