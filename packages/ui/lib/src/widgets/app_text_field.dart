import 'package:ui/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.initialValue,
    this.disabled = false,
    this.readOnly = false,
    this.textObscure = false,
    this.autoFocus = false,
    this.autoCorrect = true,
    this.enableSuggestion = true,
    this.maxLength,
    this.focusNode,
    this.scrollPadding,
    this.controller,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
  });

  final String hintText;
  final String labelText;
  final String? errorText;
  final String? initialValue;
  final bool disabled;
  final bool readOnly;
  final bool textObscure;
  final bool autoFocus;
  final bool autoCorrect;
  final bool enableSuggestion;
  final int? maxLength;
  final FocusNode? focusNode;
  final EdgeInsets? scrollPadding;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late bool _textObscure;
  bool _isFocused = false;

  bool get _hasExternalController => widget.controller != null;
  bool get _hasExternalFocusNode => widget.focusNode != null;

  @override
  void initState() {
    super.initState();
    _textObscure = widget.textObscure;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (!_hasExternalController) {
      _controller.dispose();
    }
    if (!_hasExternalFocusNode) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.errorText != null && widget.errorText!.isNotEmpty;

    final effectiveBorderColor = error
        ? context.appColors.errorBase
        : _isFocused
        ? context.appColors.primaryBase
        : context.appColors.strokeSub300;

    final effectiveBackgroundColor = widget.disabled
        ? context.appColors.bgSoft200
        : context.appColors.staticWhite;

    final effectiveTextColor = error
        ? context.appColors.errorBase
        : widget.disabled
        ? context.appColors.textSoft400
        : context.appColors.textStrong950;

    final effectiveFloatingLabelTextColor = error
        ? context.appColors.errorBase
        : widget.disabled
        ? context.appColors.textSoft400
        : context.appColors.textSub600;

    final List<BoxShadow> effectiveBoxShadow = _isFocused
        ? []
        : context.appShadows.xs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.x3s),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            border: Border.all(
              color: effectiveBorderColor,
              width: context.appBorders.defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(
              context.appBorders.borderRadiusMd,
            ),
            boxShadow: effectiveBoxShadow,
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: !widget.disabled,
            readOnly: widget.readOnly,
            autofocus: widget.autoFocus,
            autocorrect: widget.autoCorrect,
            enableSuggestions: widget.enableSuggestion,
            obscureText: _textObscure,
            scrollPadding: widget.scrollPadding ?? EdgeInsets.zero,
            maxLength: widget.maxLength,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: context.appTypography.regular.textDefault
                  .copyWith(color: effectiveFloatingLabelTextColor),
              labelStyle: context.appTypography.regular.textDefault.copyWith(
                color: context.appColors.textSoft400,
              ),
              hintStyle: context.appTypography.regular.textDefault.copyWith(
                color: context.appColors.textSoft400,
              ),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              suffixIcon: widget.textObscure
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _textObscure = !_textObscure;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: context.appSpacing.x4s),
                        child: Icon(
                          _textObscure ? Remix.eye_fill : Remix.eye_off_fill,
                          color: context.appColors.textSoft400,
                          size: context.appTypography.regular.text16.fontSize,
                        ),
                      ),
                    )
                  : null,
            ),
            cursorColor: context.appColors.primaryBase,
            style: context.appTypography.regular.textDefault.copyWith(
              color: effectiveTextColor,
              height: 1.h,
            ),
            onTapOutside: (_) => _focusNode.unfocus(),
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
          ),
        ),
        if (error) ...[
          SizedBox(height: context.appSpacing.x5s),
          Row(
            children: [
              Icon(
                Remix.error_warning_fill,
                color: context.appColors.errorBase,
                size: context.appTypography.regular.text12.fontSize,
              ),
              SizedBox(width: context.appSpacing.x5s),
              Text(
                widget.errorText!,
                style: context.appTypography.regular.text12.copyWith(
                  decorationThickness: 0,
                  decoration: TextDecoration.none,
                  color: context.appColors.errorBase,
                  height: 1.h,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
