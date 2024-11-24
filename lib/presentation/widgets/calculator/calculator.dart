import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:melloss_portifolio/bloc/bloc/calculator_bloc.dart';
import 'package:melloss_portifolio/data/models/calculator_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/file_system/file_system_bloc.dart';
import '../../../bloc/ui/ui_bloc.dart';
import '../../../gen/colors.gen.dart';
import '../button_widget.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double top = 100;
  double left = 300;
  double width = 100.sh;
  double height = 100.sw;
  String errorText = '';
  final scrollController = ScrollController();

  final inputController = TextEditingController();
  void onDragUpdate(DragUpdateDetails details) {
    if (top <= 30) {
      setState(() {
        top = 30 + 1;
      });
    } else {
      setState(() {
        top += details.delta.dy;
      });
    }
    setState(() {
      left += details.delta.dx;
      width = 70.sh;
      height = 70.sw;
    });
  }

  scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Preprocesses the input string by performing various transformations:
  /// - Replaces 'mod' with '%'
  /// - Replaces '÷' with '/'
  /// - Replaces '×' with '*'
  /// - Replaces '√number' with 'sqrt(number)'
  /// - Replaces 'number²' with 'power(number, 2)'
  ///
  /// This function is used to normalize the input expression before parsing and evaluating it.

  String preprocessInput(String input) {
    // Replace 'mod' with '%'
    input = input.replaceAll('mod', '%');

    input = input.replaceAll('÷', '/');

    input = input.replaceAll('×', '*');

    // Replace '√number' with 'sqrt(number)'
    RegExp sqrtRegex = RegExp(r'√(\d+(\.\d+)?)');
    input = input.replaceAllMapped(sqrtRegex, (match) {
      String number = match.group(1) ?? '';
      return 'sqrt($number)';
    });

    // Replace 'number²' with 'power(number, 2)'
    RegExp powerRegex = RegExp(r'(\d+)²');
    input = input.replaceAllMapped(powerRegex, (match) {
      String base = match.group(1) ?? '';
      return '$base^2';
    });

    return input;
  }

  calculationResultHandler() {
    try {
      final parser = Parser();
      final contextModel = ContextModel();
      // Extend functionality
      final expression =
          parser.parse(preprocessInput(inputController.text.trim()));

      contextModel.bindVariableName('π', Number(math.pi));
      contextModel.bindVariableName('%', Modulo(Variable('x'), Variable('y')));

      final result = expression.evaluate(EvaluationType.REAL, contextModel);
      callCalculatorBloc(result.toString());
      inputController.text = result.toString();
      scrollDown();
    } catch (error) {
      setState(() {
        errorText = 'Malformed expression';
      });
    }
  }

  void callCalculatorBloc(String result) {
    context.read<CalculatorBloc>().add(
          AddCalculationHistory(
            calculatorModel: CalculatorModel(
              expression: inputController.text,
              result: result,
            ),
          ),
        );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextt) {
    return Stack(
      children: [
        width == 100.sh
            ? _buildMainBoard()
            : Positioned(
                top: top,
                left: left,
                child: _buildMainBoard(),
              ),
      ],
    );
  }

  _buildMainBoard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: width == 100.sh ? null : BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Draggable(
            ignoringFeedbackPointer: true,
            feedback: const SizedBox.shrink(),
            onDragUpdate: onDragUpdate,
            child: _buildHeader(),
          ),
          Container(
            color: Colors.black87,
            height: 0.5,
            width: double.infinity,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 650,
                height: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      flex: height == 70.sw ? 3 : 5,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF474747),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: BlocBuilder<CalculatorBloc, CalculatorState>(
                              builder: (context, state) {
                                return ListView.separated(
                                  controller: scrollController,
                                  itemCount: state.histories.length,
                                  padding: EdgeInsets.zero,
                                  reverse: true,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: Colors.black26,
                                    thickness: 0.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: ButtonWidget(
                                        borderRadius: BorderRadius.zero,
                                        backgroundColor: const Color(
                                          0xFF474747,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  state.histories[index]
                                                      .expression,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                '=',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    state.histories[index]
                                                        .result,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          inputController.text =
                                              state.histories[index].expression;
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: ColorName.darkBlackColor.withOpacity(0.5),
                          ),
                          Container(
                            height: 65,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3D3D),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  surfaceTintColor: const Color(0xFF3D3D3D),
                                  shadowColor: const Color(0xFF3D3D3D),
                                  color: const Color(0xFF3D3D3D),
                                  child: SizedBox(
                                    width: 650,
                                    height: 40,
                                    child: TextField(
                                      controller: inputController,
                                      onEditingComplete:
                                          calculationResultHandler,
                                      autofocus: true,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      decoration: const InputDecoration(
                                        fillColor: Color(0xFF3D3D3D),
                                        filled: true,
                                        focusColor: Color(0xFF3D3D3D),
                                        hoverColor: Color(0xFF3D3D3D),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    errorText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: _buildButtons(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalculatorButton(
              "c",
              bold: true,
            ),
            _buildCalculatorButton(
              "7",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "4",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "1",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "0",
              bold: true,
              color: const Color(0xFF545454),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalculatorButton(
              "(",
              bold: true,
            ),
            _buildCalculatorButton(
              "8",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "5",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "2",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              ".",
              bold: true,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalculatorButton(
              ")",
              bold: true,
            ),
            _buildCalculatorButton(
              "9",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "6",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "3",
              bold: true,
              color: const Color(0xFF545454),
            ),
            _buildCalculatorButton(
              "%",
              bold: true,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalculatorButton(
              "mod",
            ),
            _buildCalculatorButton(
              "÷",
            ),
            _buildCalculatorButton(
              "×",
            ),
            _buildCalculatorButton(
              "-",
            ),
            _buildCalculatorButton(
              "+",
            ),
          ],
        ),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildCalculatorButton(
            "π",
          ),
          _buildCalculatorButton(
            "√",
          ),
          _buildCalculatorButton(
            "x²",
          ),
          _buildCalculatorButton(
            "=",
            height: 109,
            color: const Color(0xFFEB6536),
          ),
        ])
      ],
    );
  }

  _buildCalculatorButton(
    String text, {
    Color? color,
    bool bold = false,
    double height = 51,
  }) {
    return SizedBox(
      width: 126,
      height: height,
      child: ButtonWidget(
        backgroundColor: color ?? const Color(0xFF414141),
        onPressed: () {
          setState(() {
            errorText = '';
          });
          if (text == 'c') {
            inputController.clear();
          } else if (text == 'mod') {
            inputController.text = "${inputController.text} $text ";
          } else if (text == 'x²') {
            inputController.text = '${inputController.text}²';
          } else if (text == '=') {
            calculationResultHandler();
          } else {
            inputController.text = inputController.text + text;
          }
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: bold ? null : FontWeight.w300),
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      height: 55,
      color: ColorName.darkBlackColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Row(
            children: [
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Bootstrap.dash,
                  size: 14,
                ),
                onPressed: () {
                  final state = context.read<FileSystemBloc>().state;
                  context
                      .read<UIBloc>()
                      .add(SetMinimazedPath(path: state.currentPath));
                  context.pop();
                },
              ),
              const SizedBox(width: 7),
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Icons.check_box_outline_blank,
                  size: 14,
                ),
                onPressed: () {
                  if (width == 100.sh) {
                    setState(() {
                      width = 70.sh;
                      height = 70.sw;
                    });
                  } else {
                    setState(() {
                      width = 100.sh;
                      height = 100.sw;
                    });
                  }
                },
              ),
              const SizedBox(width: 7),
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Icons.close,
                  size: 14,
                ),
                onPressed: () {
                  context.read<UIBloc>().add(
                        const IsCalculatorOpened(isOpened: false),
                      );
                  context.read<UIBloc>().add(
                        const SetMinimazedPath(path: ['/']),
                      );

                  context.pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
