import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../data/models/question.dart';

part 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {
  int questionNumber = 0;
  int score = 0;
  static bool _isDark = true;
  ThemeMode themeMode = ThemeMode.light;

  CheckCubit() : super(CheckInitial(0, 0,ThemeMode.light));

  void checkAnswer(bool userPickedAnswer, BuildContext context) {
    bool correctAnswer = QuizzQuestion.getCorrectAnswer();

    if (QuizzQuestion.isFinished() == true) {
      Alert(
        context: context,
        title: 'Finit',
        desc: 'Votre score est de ' + score.toString(),
      ).show();
      QuizzQuestion.reset();
      emit(CheckInitial(questionNumber, score,themeMode));
      score = 0;
    } else {
      if (userPickedAnswer == correctAnswer) {
        score = score + 1;
      }
      QuizzQuestion.nextQuestion();
      emit(CheckInitial(questionNumber, score,themeMode));
    }
  }

  void checkAnswerNext(BuildContext context) {
    bool correctAnswer = QuizzQuestion.getCorrectAnswer();

    if (QuizzQuestion.isFinished() == true) {
      Alert(
        context: context,
        title: 'Finit',
        desc: 'Votre score est de ' + score.toString(),
      ).show();
      QuizzQuestion.reset();
      emit(CheckInitial(questionNumber, score,themeMode));
      score = 0;
    } else {
      QuizzQuestion.nextQuestion();
      emit(CheckInitial(questionNumber, score,themeMode));
    }
  }

  ThemeMode currentTheme() {
    themeMode = _isDark ? ThemeMode.dark : ThemeMode.light;
    emit(CheckInitial(questionNumber, score,themeMode));
    return themeMode;
  }

  void switchTheme() {
    _isDark = !_isDark;
    emit(CheckInitial(questionNumber, score,themeMode));
  }
}