import 'package:customer_app/core/theme/app_colors.dart';
import 'package:customer_app/core/utils/validators.dart';
import 'package:customer_app/shared/widgets/app_text_field.dart';
import 'package:customer_app/shared/widgets/aurora_backdrop.dart';
import 'package:customer_app/shared/widgets/brand_mark.dart';
import 'package:customer_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    // Dummy submission state for UI testing
    setState(() => _submitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _submitting = false);
        // Add actual navigation or state handling here later
      }
    });
  }

  void _openSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const Placeholder()),
    );
  }

  void _openForgotPassword() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ForgotPasswordSheet(email: _emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AuroraBackdrop(),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: _buildForm(),
                      ), // ConstrainedBox
                    ), // Center
                  ), // SingleChildScrollView
                ), // Expanded
              ],
            ), // Column
          ), // SafeArea
        ],
      ), // Stack
    ); // Scaffold
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const _Heading(),
            const SizedBox(height: 28),
            AppTextField(
              label: 'Email',
              controller: _emailController,
              hint: 'you@example.com',
              prefixIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.username],
              enabled: !_submitting,
              validator: Validators.email,
              onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
            ), // AppTextField
            const SizedBox(height: 18),
            AppTextField(
              label: 'Password',
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              hint: 'Your password',
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              enabled: !_submitting,
              validator: Validators.requiredPassword,
              onFieldSubmitted: (_) => _submit(),
            ), // AppTextField
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _submitting ? null : _openForgotPassword,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ), // EdgeInsets.symmetric
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ), // TextButton.styleFrom
                child: const Text('Forgot password?'),
              ), // TextButton
            ), // Align
            const SizedBox(height: 18),
            GradientButton(
              label: _submitting ? 'Signing in...' : 'Sign in',
              icon: _submitting ? null : Icons.arrow_forward_rounded,
              busy: _submitting,
              onPressed: _submitting ? null : _submit,
            ), // GradientButton
            const SizedBox(height: 18),
            _buildSignUpPrompt(),
          ],
        ), // Column
      ), // AutofillGroup
    ); // Form
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 24, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: _submitting ? null : () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.ink,
            tooltip: 'Back',
          ), // IconButton
          const Spacer(),
          const BrandMark(height: 30),
        ],
      ), // Row
    ); // Padding
  }

  Widget _buildSignUpPrompt() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'New to Wingo?',
          style: TextStyle(fontSize: 14.5, color: AppColors.inkMuted),
        ), // Text
        TextButton(
          onPressed: _submitting ? null : _openSignUp,
          child: const Text('Create an account'),
        ), // TextButton
      ],
    ); // Wrap
  }
}

class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 30,
            height: 1.2,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: AppColors.ink,
          ), // TextStyle
        ), // Text
        SizedBox(height: 8),
        Text(
          'Sign in to track your parcels and send something new.',
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: AppColors.inkMuted,
          ), // TextStyle
        ), // Text
      ],
    ); // Column
  }
}

class _ForgotPasswordSheet extends StatelessWidget {
  const _ForgotPasswordSheet({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ), // EdgeInsets.fromLTRB
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ), // BoxDecoration
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 44,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ), // BoxDecoration
            ), // Container
          ), // Center
          const SizedBox(height: 22),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(18),
            ), // BoxDecoration
            child: const Icon(
              Icons.lock_reset_rounded,
              color: AppColors.accentDark,
              size: 28,
            ), // Icon
          ), // Container
          const SizedBox(height: 18),
          const Text(
            'Reset your password',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: AppColors.ink,
            ), // TextStyle
          ), // Text
          const SizedBox(height: 10),
          Text(
            email.isEmpty
                ? 'Password reset is not switched on yet. Contact support and '
                      'we will get you back in.'
                : 'Password reset is not switched on yet. Contact support from '
                      '$email and we will get you back in.',
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.inkMuted,
            ), // TextStyle
          ), // Text
          const SizedBox(height: 22),
          GradientButton(
            label: 'Got it',
            onPressed: () => Navigator.of(context).pop(),
          ), // GradientButton
          const SizedBox(height: 6),
        ],
      ), // Column
    ); // Container
  }
}
