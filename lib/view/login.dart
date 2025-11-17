// views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/login_viewmodel.dart'; // Sesuaikan path

class Login extends GetView<LoginViewModel> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Stack untuk menumpuk tombol di atas
        child: Stack(
          children: [
            // Konten utama (Scrollable)
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    // Paksa tinggi minimal se-layar penuh
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    // IntrinsicHeight diperlukan agar Expanded berfungsi
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
                                'Login',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),

                            // --- BAGIAN 2: FIELDS (DI TENGAH) ---
                            // Gunakan Expanded untuk mengambil semua sisa ruang
                            Expanded(
                              child: Column(
                                // Pusatkan field di dalam ruang 'Expanded'
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _buildInputDecoration(
                                      hint: 'Email',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: controller.passwordController,
                                    obscureText: true,
                                    decoration: _buildInputDecoration(
                                      hint: 'Password',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: controller.goToSignUp,
                                    child: Text(
                                      "Don't have an account? Sign up",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // --- BAGIAN 3: PADDING BAWAH ---
                            // Beri ruang agar tombol 'LOGIN' tidak
                            // menutupi 'Sign up'
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // --- TOMBOL LOGIN (MENEMPEL DI KANAN BAWAH) ---
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Jarak dari tepi layar
                child: Obx(
                  () => FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(120, 55),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('LOGIN'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk Style TextField (TETAP SAMA)
  InputDecoration _buildInputDecoration({required String hint}) {
    // Ambil warna default dari theme Anda
    final Color fillColor =
        Theme.of(Get.context!).inputDecorationTheme.fillColor ??
        const Color(0xFFF0F0F0);

    return InputDecoration(
      hintText: hint,
      // 4. Tambahkan padding horizontal agar tulisan "agak masuk"
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20, // <-- Ini padding horizontalnya
      ),
      border: OutlineInputBorder(
        // 3. Set borderRadius kustom
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: fillColor,
    );
  }
}

