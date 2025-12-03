import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/app_theme.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

class UnderlineField extends StatefulWidget {
  const UnderlineField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffix,
    this.onChanged,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final SvgGenImage? prefixIcon;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final List<String>? autofillHints;

  @override
  State<UnderlineField> createState() => _UnderlineFieldState();
}

class _UnderlineFieldState extends State<UnderlineField>
    with SingleTickerProviderStateMixin {
  late final FocusNode _focusNode;
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode()..addListener(_onFocusChange);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );

    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveColor = ColorName.nobel;
    final activeColor = ColorName.cornflowerBlue;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                widget.prefixIcon!.svg(),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  autofillHints: widget.autofillHints,
                  style: AppTextStyles.fieldValue,
                  textInputAction: TextInputAction.next,
                  cursorOpacityAnimates: true,
                  cursorWidth: 1.5,
                  cursorRadius: const Radius.circular(12),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: AppTextStyles.hint,
                  ),
                ),
              ),
              if (widget.suffix != null) ...[
                SizedBox(width: 8.w),
                widget.suffix!,
              ],
            ],
          ),
        ),

        // === UNDERLINE ANIMATION FROM CENTER ===
        SizedBox(
          height: 2,
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 1, color: inactiveColor),

                  FractionallySizedBox(
                    widthFactor: _anim.value,
                    alignment: Alignment.center,
                    child: Container(height: 2, color: activeColor),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
