import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final FocusNode? focusNext;
  final FormFieldValidator<String> onValidate;
  final FormFieldValidator<String>? onChanged;
  final Function? onSubmitted;
  final String? label;
  final Widget? labelWidget;
  final String? placeholder;
  final String? initialValue;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final double fontSize;
  final bool? enabled;
  final TextAlign textAlign;
  final Widget? prefix;
  final OverlayVisibilityMode clearButtonMode;
  final double inputFontSize;
  final int? maxLength;

  TextFieldCustom({
    this.controller,
    required this.label,
    this.labelWidget,
    required this.focus,
    required this.onValidate,
    this.onChanged,
    this.focusNext,
    this.placeholder,
    this.initialValue,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.fontSize = 14,
    this.inputFontSize = 18,
    this.maxLength,
    this.enabled,
    this.textAlign = TextAlign.left,
    this.prefix,
    this.clearButtonMode = OverlayVisibilityMode.editing,
  });

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  var _value;
  var _error;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    if (widget.initialValue != null) {
      setState(() {
        _value = widget.initialValue;
      });

      if (widget.controller != null) {
        widget.controller!.text = widget.initialValue!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        var err = widget.onValidate(_value);

        setState(() {
          _error = err;
        });

        return err;
      },
      builder: (field) {
        return Column(
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.centerStart,
              margin: EdgeInsets.only(bottom: 4),
              child: widget.labelWidget != null
                  ? widget.labelWidget
                  : Text(
                      widget.label!,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: widget.fontSize,
                      ),
                    ),
            ),
            CupertinoTextField(
              controller: widget.controller,
              maxLength: widget.maxLength,
              style: TextStyle(fontSize: widget.inputFontSize),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: widget.focus!.hasFocus
                      ? Colors.lightBlueAccent
                      : _error != null
                          ? Colors.red
                          : Colors.black54,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              prefix: Padding(
                padding: widget.prefix != null
                    ? EdgeInsets.all(8.0)
                    : EdgeInsets.all(0),
                child: widget.prefix,
              ),
              prefixMode: OverlayVisibilityMode.always,
              suffix: widget.obscureText
                  ? TextButton(
                      child: _obscureText ? Text('MOSTRAR') : Text('OCULTAR'),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    )
                  : null,
              enabled: widget.enabled,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              suffixMode: OverlayVisibilityMode.editing,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              focusNode: widget.focus,
              clearButtonMode: widget.clearButtonMode,
              obscureText: _obscureText,
              onEditingComplete: () {
                widget.focus!.unfocus();

                if (widget.focusNext != null) {
                  FocusScope.of(context).requestFocus(widget.focusNext);
                }
              },
              onChanged: (value) {
                var err = widget.onValidate(value);

                setState(() {
                  _value = value;
                  _error = err;
                });

                field.didChange(value);

                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              onSubmitted: (value) {
                widget.focus!.unfocus();

                var err = widget.onValidate(value);

                setState(() {
                  _value = value;
                  _error = err;
                });

                if (widget.onSubmitted != null) {
                  widget.onSubmitted!();
                }

                field.didChange(value);
              },
              placeholder: widget.placeholder,
              padding: EdgeInsets.all(8),
              textAlign: widget.textAlign,
            ),
            if (_error != null)
              Container(
                alignment: AlignmentDirectional.centerStart,
                margin: EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  _error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
