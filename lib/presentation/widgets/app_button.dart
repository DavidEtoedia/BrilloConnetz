import 'package:brillo_connetz/presentation/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  final bool isLoading;
  final Color textColor;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            ] else ...[
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class ClickableText extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final void Function()? onPressed;
  const ClickableText(
      {super.key,
      required this.color,
      required this.text,
      this.textSize = 15.0,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: textSize,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: textSize,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
