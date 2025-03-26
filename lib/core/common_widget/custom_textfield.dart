import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/common_widget/text_view.dart';
import 'package:weather_app/core/extensions/theme_extension.dart';
import 'package:weather_app/core/extensions/widget_extension.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_styles.dart';
import 'package:weather_app/core/utils/custom_debouncer.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final String? title;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final InputBorder? border;
  final int? maxLines;
  final int? minLines;
  final bool isError;
  final int? maxLength;
  final bool enabled;
  final Function(String val)? onChanged;
  final Function()? onTap;
  final bool autoFocus;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool isReadOnly;
  final double? height;
  final bool showCharCount;
  final String? error;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.hintStyle,
    this.suffixIcon,
    this.contentPadding,
    this.title,
    this.focusNode,
    this.obscureText = false,
    this.textInputType,
    this.textInputAction,
    this.border,
    this.maxLines,
    this.isError = false,
    this.maxLength,
    this.onChanged,
    this.enabled = true,
    this.onTap,
    this.autoFocus = false,
    this.inputFormatters = const [],
    this.textCapitalization,
    this.prefixIcon,
    this.backgroundColor,
    this.validator,
    this.isRequired = false,
    this.isReadOnly = false,
    this.minLines,
    this.height,
    this.showCharCount = false,
    this.error,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool visiblePassword;
  @override
  void initState() {
    super.initState();
    visiblePassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    bool isError = widget.error != null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              text: widget.title,
              style: AppStyles.medium500(color: AppColors.hintColor).copyWith(
                fontSize: 14.sp,
              ),
              children: [
                if (widget.isRequired) ...[
                  TextSpan(
                    text: " *",
                    style: AppStyles.medium500(color: AppColors.hintColor)
                        .copyWith(
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ],
            ),
          ),
          8.sp.hSpace,
        ],
        Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minHeight: maxHeight,
            maxHeight: maxHeight,
          ),
          child: TextFormField(
            onTap: widget.onTap,
            textCapitalization:
                widget.textInputType == TextInputType.emailAddress
                    ? TextCapitalization.none
                    : widget.textCapitalization ?? TextCapitalization.sentences,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            autofocus: widget.autoFocus,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            obscureText: visiblePassword,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              enabledBorder: widget.border ??
                  inputBorder(context: context, isError: isError),
              disabledBorder: widget.border ??
                  inputBorder(context: context, isError: isError),
              focusedBorder: widget.border ??
                  inputBorder(context: context, isError: isError),
              hintText: widget.hint ?? "Type here...",
              hintStyle: widget.hintStyle ??
                  AppStyles.medium500(color: context.theme.hintColor)
                      .copyWith(fontSize: 14.sp),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                      },
                      child: Icon(
                        !visiblePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.colorGrey500,
                        size: 16.sp,
                      ),
                    )
                  : widget.suffixIcon,
              enabled: widget.enabled,
              counterText: widget.showCharCount ? null : "",
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: 12.sp,
                      vertical: (widget.maxLines ?? 0) > 1 ? 12.sp : 0.sp),
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints:
                  BoxConstraints(minWidth: 10.w, maxWidth: 18.w),
              fillColor: widget.enabled
                  ? widget.backgroundColor ?? AppColors.whiteColor
                  : AppColors.colorGrey300,
              filled: true,
            ),
            cursorColor: AppColors.hintColor,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            style: AppStyles.medium500(color: AppColors.blackColor)
                .copyWith(fontSize: 14.sp),
            validator: widget.validator ??
                (value) {
                  if (value?.isEmpty == true && widget.isRequired) {
                    return '${widget.title} is required';
                  }
                  return null;
                },
          ),
        ),
        if (widget.error != null) ...[
          8.sp.hSpace,
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.colorGoogleRed400,
                size: 15.sp,
              ),
              6.sp.wSpace,
              Expanded(
                child: TextView(
                  widget.error,
                  style: AppStyles.medium500(color: AppColors.colorGoogleRed400)
                      .copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  InputBorder? inputBorder(
          {required bool isError, required BuildContext context}) =>
      isError
          ? context.theme.inputDecorationTheme.errorBorder
          : context.theme.inputDecorationTheme.border;

  double get maxHeight {
    return widget.height ?? (widget.showCharCount ? (8.sp + 18.sp) : 8.sp);
  }
}

class CustomSearchTextField extends StatefulWidget {
  final String? hint;
  final Function(String) onChanged;
  const CustomSearchTextField({
    super.key,
    this.hint,
    required this.onChanged,
  });

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late CustomDebouncer _customDebouncer;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _customDebouncer = CustomDebouncer<String>(
      const Duration(milliseconds: 500),
      (value) {
        widget.onChanged(value);
      },
    );

    controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      height: 25.sp,
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(8.sp)),
      backgroundColor: Colors.white.withValues(alpha: 1),
      prefixIcon: Icon(
        Icons.search,
        color: AppColors.hintColor,
        size: 14.sp,
      ),
      hint: widget.hint ?? "Search...",
      suffixIcon: controller.text.isEmpty
          ? null
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                controller.clear();
                FocusManager.instance.primaryFocus?.unfocus();
                _customDebouncer.value = "";
              },
              child: Icon(
                Icons.close,
                color: AppColors.hintColor,
                size: 16.sp,
              ),
            ),
      onChanged: (val) => _customDebouncer.value = val,
    );
  }

  @override
  void dispose() {
    _customDebouncer.timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}
