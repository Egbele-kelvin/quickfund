
import 'package:flutter/cupertino.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class QuestionListedOut extends StatelessWidget {
  QuestionListedOut({
    Key key,
    @required this.size,
    @required this.postMdl,
    @required this.idQuestion1,
    @required this.question1,
  }) : super(key: key);

  final Size size;
  String idQuestion1;
  final SecurityQuestionProvider postMdl;
  final TextEditingController question1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.8,
      child: Column(
        children: [
          CustomDetails(
            heading: 'List of Security Questions',
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            height: size.height * 0.6,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: postMdl.data
                  .asMap()
                  .entries
                  .map((e) => CustomListTile(
                onTap: () {
                  question1.text = e.value.question;
                  idQuestion1 = e.value.id.toString();
                  print('question1: ${question1.text}');
                  print('idQuestion1: $idQuestion1');
                  Navigator.pop(context);
                },
                title: '${e.value.question}',
              ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class QuestionListedOut2 extends StatelessWidget {
  QuestionListedOut2({
    Key key,
    @required this.size,
    @required this.postMdl,
    @required this.question2,
    @required this.idQuestion2,
  }) : super(key: key);

  final Size size;
  String idQuestion2;
  final SecurityQuestionProvider postMdl;
  final TextEditingController question2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.8,
      child: Column(
        children: [
          CustomDetails(
            heading: 'List of Security Questions',
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            height: size.height * 0.6,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: postMdl.data
                  .asMap()
                  .entries
                  .map((e) => CustomListTile(
                onTap: () {
                  question2.text = e.value.question;
                  idQuestion2 = e.value.id.toString();
                  print('question2: ${question2.text}');
                  print('idQuestion2: $idQuestion2');
                  Navigator.pop(context);
                },
                title: '${e.value.question}',
              ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
