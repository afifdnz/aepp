// views/register_step3_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/register_viewmodel.dart'; // Sesuaikan path

// Gunakan RegisterViewModel yang sama
class RegisterStep3Screen extends GetView<RegisterViewModel> {
  const RegisterStep3Screen({super.key});

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
                                    controller: controller.usernameController,
                                    decoration: _buildInputDecoration(
                                      hint: '@username',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    // Tombol ini kembali ke Step 2
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      "Back to previous step",
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
                // Obx untuk menampilkan loading spinner
                child: Obx(
                  () => FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(120, 55),
                    ),
                    // Panggil submitRegistration (fungsi final)
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitRegistration,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('SIGN UP'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk Style TextField (Sama seperti di Login/Step 1)
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
