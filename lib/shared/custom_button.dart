import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.fontSize,
    this.backgroundColor,
    this.fontColor,
    this.height,
    this.borderColor,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String text;
  final double? fontSize;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? borderColor;
  final double? height;

  final bool isLoading;
  final bool isEnabled;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final baseColor = widget.isEnabled
        ? widget.backgroundColor ?? ColorName.cornflowerBlue
        : ColorName.nobel;

    final bool isInteractive = widget.onTap != null && !widget.isLoading;

    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: isInteractive ? widget.onTap : null,
          borderRadius: radius,
          splashColor: isInteractive
              ? Colors.white.withOpacity(0.15)
              : Colors.transparent,
          highlightColor: isInteractive
              ? Colors.black.withOpacity(0.05)
              : Colors.transparent,
          onHighlightChanged: isInteractive
              ? (value) {
                  setState(() => _isPressed = value);
                }
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            alignment: Alignment.center,
            height: widget.height ?? 56.h,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: radius,
              border: Border.all(color: widget.borderColor ?? baseColor),
              boxShadow: _isPressed
                  ? [
                      BoxShadow(
                        color: baseColor.withOpacity(0.45),
                        offset: const Offset(0, 6),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: widget.isLoading
                  ? Row(
                      key: const ValueKey('loading'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.fontColor ?? ColorName.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'جاري التحميل...',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: widget.fontColor ?? ColorName.white,
                            fontSize: widget.fontSize ?? 16.0,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(width: 24),

                        Expanded(
                          child: Center(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: widget.fontColor ?? ColorName.white,
                                fontSize: widget.fontSize ?? 16.0,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Assets.icons.arrowBack.svg(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
