import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/error_banner.dart';
import '../../widgets/glass_container.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isRegister = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'FARMER';
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authProvider.notifier);
    if (_isRegister) {
      await auth.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: _selectedRole,
      );
    } else {
      await auth.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _demoLogin(String role) async {
    final email = '$role@demo.paralisetu.org';
    const password = 'ParaliDemo123!';
    _emailController.text = email;
    _passwordController.text = password;
    await ref.read(authProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Brand Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 44,
                      height: 44,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.eco,
                        color: AppColors.brandGreen,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: const TextSpan(
                        text: 'Parali',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Setu',
                            style: TextStyle(
                              color: AppColors.brandSeed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Main Auth Glass Card
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Tab Selector
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => setState(() => _isRegister = false),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: !_isRegister ? Colors.white : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: !_isRegister
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.05),
                                                blurRadius: 4,
                                              )
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontWeight: !_isRegister ? FontWeight.bold : FontWeight.normal,
                                          color: !_isRegister ? AppColors.textPrimary : AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => setState(() => _isRegister = true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: _isRegister ? Colors.white : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: _isRegister
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.05),
                                                blurRadius: 4,
                                              )
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Create account',
                                        style: TextStyle(
                                          fontWeight: _isRegister ? FontWeight.bold : FontWeight.normal,
                                          color: _isRegister ? AppColors.textPrimary : AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          _isRegister ? 'Create your account' : 'Welcome back',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 14),

                        if (authState.error != null)
                          ErrorBanner(
                            message: authState.error,
                            onDismiss: () => ref.read(authProvider.notifier).clearError(),
                          ),

                        if (_isRegister) ...[
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                              hintText: 'e.g. Gurpreet Singh',
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                          ),
                          const SizedBox(height: 14),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedRole,
                            decoration: const InputDecoration(labelText: 'Account type'),
                            items: const [
                              DropdownMenuItem(value: 'FARMER', child: Text('Farmer')),
                              DropdownMenuItem(value: 'BUYER', child: Text('Buyer / Biomass Plant')),
                            ],
                            onChanged: (v) => setState(() => _selectedRole = v ?? 'FARMER'),
                          ),
                          const SizedBox(height: 14),
                        ],

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                            hintText: 'name@example.com',
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Email is required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Password is required';
                            if (_isRegister && v.length < 10) return 'Minimum 10 characters required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        FilledButton(
                          onPressed: authState.isLoading ? null : _submit,
                          child: authState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(_isRegister ? 'Register' : 'Sign in'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Quick Demo Accounts Panel
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Demo Quick Access',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          OutlinedButton(
                            onPressed: () => _demoLogin('farmer'),
                            child: const Text('Farmer (Gurpreet)'),
                          ),
                          OutlinedButton(
                            onPressed: () => _demoLogin('buyer'),
                            child: const Text('Buyer (GreenField)'),
                          ),
                          OutlinedButton(
                            onPressed: () => _demoLogin('logistics'),
                            child: const Text('Logistics (Punjab)'),
                          ),
                          OutlinedButton(
                            onPressed: () => _demoLogin('admin'),
                            child: const Text('Admin'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
