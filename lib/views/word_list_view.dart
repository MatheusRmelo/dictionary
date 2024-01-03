import 'package:dictionary/views/widgets/tab_option_widget.dart';
import 'package:flutter/material.dart';

class WordListView extends StatefulWidget {
  const WordListView({super.key});

  @override
  State<WordListView> createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Word list',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
            child: GridView.builder(
          itemCount: 5,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) => TabOptionWidget(
            title: 'Hello',
            isLast: true,
          ),
        ))
      ],
    );
  }
}
