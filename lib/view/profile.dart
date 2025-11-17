import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/profile_viewmodel.dart';

class Profile extends GetView<ProfileViewModel> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildOptionsList(),
            const SizedBox(height: 30),
            _buildAboutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 30, backgroundColor: Colors.white),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.userHandle,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildOptionItem(
            title: 'My Account',
            subtitle: 'Make changes to your account',
            onTap: controller.goToMyAccount,
            isDarkMode: false, // Kartu putih
          ),
          _buildOptionItem(
            title: 'My Orders',
            subtitle: 'See your order histroy',
            onTap: controller.goToMyOrders,
            isDarkMode: false, // Kartu putih
          ),
          _buildOptionItem(
            title: 'Shipping Address',
            subtitle: 'Set your addresses',
            onTap: controller.goToShippingAddress,
            isDarkMode: false, // Kartu putih
          ),
          _buildOptionItem(
            title: 'Logout',
            subtitle: 'Futher secure your account for safely',
            onTap: controller.logout,
            isDarkMode: false, // Kartu putih
            isLastItem: true, // Untuk menghapus margin bawah
          ),
        ],
      ),
    );
  }

  Widget _buildAboutButton() {
    return _buildOptionItem(
      title: 'About App',
      onTap: controller.goToAboutApp,
      isDarkMode: true,
    );
  }

  Widget _buildOptionItem({
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool showArrow = true,
    required bool isDarkMode,
    bool isLastItem = false,
  }) {
    final Color cardColor = isDarkMode ? const Color(0xFF222222) : Colors.white;
    final Color titleColor = isDarkMode ? Colors.white : Colors.black;
    final Color subtitleColor = isDarkMode
        ? Colors.grey[400]!
        : Colors.grey[600]!;
    final Color arrowColor = isDarkMode ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        // Beri margin bawah HANYA jika ini kartu putih & BUKAN item terakhir
        margin: (isDarkMode || isLastItem)
            ? null
            : const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: subtitleColor),
                    ),
                  ],
                ],
              ),
            ),
            if (showArrow)
              Icon(Icons.arrow_forward_ios, size: 16, color: arrowColor),
          ],
        ),
      ),
    );
  }
}
