import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:flutter_fast_lib_template/constant/app_constant.dart';
import 'package:flutter_fast_lib_template/main.dart';
import 'package:flutter_fast_lib_template/util/app_util.dart';

///基于[TextFormField]封装
class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    this.autoValidateMode,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.border,
    this.obscureText = false,
    this.enabled = true,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatter,
    this.autoFocus = false,
    this.noSpace = true,
    this.margin,
    this.contentPadding,
  }) : super(key: key);
  final AutovalidateMode? autoValidateMode;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final InputBorder? border;

  ///是否可操作-用于设置不可编辑
  final bool enabled;

  ///键盘action模式
  final TextInputAction? textInputAction;

  ///键盘模式
  final TextInputType? keyboardType;

  ///最多输入字数
  final int? maxLength;

  ///最大行数
  final int maxLines;

  ///最小行数
  final int? minLines;

  ///输入控制
  final List<TextInputFormatter>? inputFormatter;

  ///是否自动获取焦点-获取焦点弹出软键盘
  final bool autoFocus;

  ///是否不能输入空格
  final bool noSpace;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  ///输入过滤
  List<TextInputFormatter> _formatter = [];

  @override
  void initState() {
    super.initState();
    _formatter = widget.inputFormatter ?? [];

    ///设置最大输入字符数
    _formatter.add(
      LengthLimitingTextInputFormatter(
        widget.maxLength,
      ),
    );

    ///过滤表情
    _formatter.add(
      EmojiFormatter(
        regexTip: appString.tipCannotInputEmojiStr,
      ),
    );

    ///过滤特殊字符
    _formatter.add(
      SpecialStrFormatter(
        regexTip: appString.tipCannotInputSpecialStr,
      ),
    );

    ///过滤空格
    if (widget.noSpace) {
      _formatter.add(SpaceInputFormatter());
    }
  }

  @override
  Widget build(BuildContext context) {
    var _field = TextFormField(
      autovalidateMode: widget.autoValidateMode,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      textAlign: TextAlign.justify,
      textAlignVertical: TextAlignVertical.center,
      maxLength: widget.maxLength,
      inputFormatters: _formatter,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding,
        isCollapsed: false,
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppConstant.defaultRadius),
              ),
            ),
      ),
    );
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: _field,
    );
  }
}

///字符过滤器
class TextFieldInputFormatter extends TextInputFormatter {
  final String regex;
  final String? regexTip;

  TextFieldInputFormatter(
    this.regex, {
    this.regexTip,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    ///新字符包含表情
    if (matches(regex, newValue.text)) {
      FastLogUtil.e('newValue:${newValue.text}', tag: 'newValueTag');
      if (ObjectUtil.isNotEmpty(regexTip)) {
        FastToastUtil.showError(regexTip!);
      }
      String finalText = getSameStr(newValue.text, oldValue.text, regex);
      return TextEditingValue(
        text: finalText,

        /// 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: oldValue.text.length,
          ),
        ),
      );
    }
    return newValue;
  }

  static bool matches(String regex, String input) {
    return RegExp(regex).hasMatch(input);
  }
}

///表情过滤器
class EmojiFormatter extends TextFieldInputFormatter {
  static const String regexStr =
      "[\\ud83c-\\udc00]|[\\ud83c-\\udfff]|[\\ud83d-\\udc00]|[\\ud83d-\\udfff]|[\\u2600-\\u27ff]";
  static const tipStr = '不能输入表情';

  EmojiFormatter({String? regexTip})
      : super(
          regexStr,
          regexTip: regexTip ?? tipStr,
        );
}

///特殊字符过滤器
class SpecialStrFormatter extends TextFieldInputFormatter {
  ///中文输入过程中有 单引号'
  static const String regexStr =
      "[`~!#\$%^&*()+=|{}:;\\[\\]<>/?~！#￥%……&*（）——+|{}【】‘；：”“’]";
  static const tipStr = '不能输入特殊字符';

  SpecialStrFormatter({String? regexTip})
      : super(
          regexStr,
          regexTip: regexTip ?? tipStr,
        );
}

///字符过滤器
class SpaceInputFormatter extends TextInputFormatter {
  SpaceInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    ///新字符包含空格
    if (newValue.text.contains(' ')) {
      String finalText = newValue.text.replaceAll(' ', '');
      return TextEditingValue(
        text: finalText,

        /// 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: oldValue.text.length,
          ),
        ),
      );
    }
    return newValue;
  }

  static bool matches(String regex, String input) {
    return RegExp(regex).hasMatch(input);
  }
}
