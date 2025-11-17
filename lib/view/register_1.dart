// views/register_step1_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/register_viewmodel.dart'; // Sesuaikan path

// Gunakan RegisterViewModel yang sama
class RegisterStep1Screen extends GetView<RegisterViewModel> {
  const RegisterStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- BAGIAN 1: JUDUL (DI ATAS) ---
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 40.0,
                              ),
                              child: Text(
                                'Sign up',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),

                            // --- BAGIAN 2: FIELDS (DI TENGAH) ---
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    // Gunakan controller dari ViewModel bersama
                                    controller: controller.nameController,
                                    decoration: _buildInputDecoration(
                                      hint: 'Nama',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _buildInputDecoration(
                                      hint: 'Email',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: controller.dobController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: _buildInputDecoration(
                                      hint: 'Tanggal Lahir (Opsional)',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: controller.goToLogin,
                                    child: Text(
                                      "Already have an account? Login",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100), // Padding bawah
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // --- TOMBOL NAVIGASI (KANAN BAWAH) ---
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(120, 55),
                  ),
                  // Panggil goToStep2, BUKAN signUp
                  onPressed: controller.goToStep2,
                  child: const Text('NEXT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk Style TextField (Sama seperti di Login)
  InputDecoration _buildInputDecoration({required String hint}) {
    final Color fillColor =
        Theme.of(Get.context!).inputDecorationTheme.fillColor ??
        const Color(0xFFF0F0F0);
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: fillColor,
    );
  }
}
