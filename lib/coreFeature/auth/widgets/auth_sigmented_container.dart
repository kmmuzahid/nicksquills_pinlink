import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class AuthSigmentedContainer extends StatefulWidget {
  final Widget Function(Function() changeToLogin) loginWidget;
  final Widget Function(Function() changeToSignup) signupWidget;

  const AuthSigmentedContainer({super.key, required this.loginWidget, required this.signupWidget});

  @override
  State<AuthSigmentedContainer> createState() => _AuthSigmentedContainerState();
}

class _AuthSigmentedContainerState extends State<AuthSigmentedContainer> {
  final String singUpTittle = 'Create Your PinLinks Profile';
  final String signInTittle = 'Welcome Back';
  final String singUpSubTitle = 'Start tracking, comparing, and sharing the golf courses you play.';
  final String signInSubTitle = 'Continue your golf journey right where you left off.';
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.height,
        CommonText(
          text: selectedIndex == 0 ? singUpTittle : signInTittle,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ).center,
        CommonText(
          text: selectedIndex == 0 ? singUpSubTitle : signInSubTitle,
          fontSize: 16,
          maxLines: 3,
          isDescription: true,
          textColor: AppColor.subtitleColor,
        ).center,
        20.height,
        _buildSegmentedButton(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),

        20.height,

        Expanded(
          child: selectedIndex == 0
              ? widget.signupWidget(() {
                  setState(() {
                    selectedIndex = 1;
                  });
                })
              : widget.loginWidget(() {
                  setState(() {
                    selectedIndex = 0;
                  });
                }),
        ),
        50.height,
      ],
    );
  }

  Widget _buildSegmentedButton({required Function(int) onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.surfaceColor.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColor.outlineColor, width: 1.2),
      ),

      child: Row(
        children: [
          _buildSegmentButton(index: 0, onTap: onTap),
          _buildSegmentButton(index: 1, onTap: onTap),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({required int index, required Function(int) onTap}) {
    final segments = <String>['Sign Up', 'Sign In'];
    const radious = 40.0;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: selectedIndex == index ? null : Colors.transparent,
            gradient: selectedIndex == index
                ? const LinearGradient(
                    colors: [Color(0xFF184F3A), Color(0xFF2F6F57)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(radious)),
          ),
          child: Center(
            child: CommonText(
              text: segments[index],
              textColor: AppColor.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
