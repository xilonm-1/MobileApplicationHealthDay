import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/background_wrapper.dart';

// ===== Model =====
class RewardItem {
  final String title;
  final int points;
  final String description;
  final String descriptionTh;
  final Color titleColor;
  final String? previewText;
  final Color? previewTextColor;

  const RewardItem({
    required this.title,
    required this.points,
    required this.description,
    required this.descriptionTh,
    required this.titleColor,
    this.previewText,
    this.previewTextColor,
  });
}

// ===== Page =====
class RewardsShopPage extends StatefulWidget {
  final int userPoints;

  const RewardsShopPage({super.key, this.userPoints = 0});

  @override
  State<RewardsShopPage> createState() => _RewardsShopPageState();
}

class _RewardsShopPageState extends State<RewardsShopPage> {
  int? _expandedIndex;
  int? _pressedIndex; // ติดตาม index ที่กำลังกดอยู่

  final List<RewardItem> _rewards = const [
    RewardItem(
      title: 'AT 1 HOUR',
      points: 1000,
      description: 'you can redeem your AT by using 1000 pts.',
      descriptionTh: 'สามารถแลกชั่วโมง AT ได้จาก 1000 pts และได้จำกัดแค่ 1 ครั้ง',
      titleColor: Color(0xFF0F2A34),
    ),
    RewardItem(
      title: 'AT 3 HOUR',
      points: 3000,
      description: 'you can redeem your AT by using 3000 pts.',
      descriptionTh: 'สามารถแลกชั่วโมง AT ได้จาก 3000 pts และได้จำกัดแค่ 1 ครั้ง',
      titleColor: Color(0xFF00C2A8),
    ),
    RewardItem(
      title: 'SPECIAL TITLES',
      points: 10000,
      description:
          'Unlock this special title to display under your name. Show everyone your dedication!',
      descriptionTh:
          'ปลดล็อคยศพิเศษได้ชื่อของคุณ ให้ทุกคนได้เห็นถึงความทุ่มเทของคุณ!',
      titleColor: Color(0xFF0F2A34),
      previewText: '( Legendary Healthy )',
      previewTextColor: Color(0xFFFFA726),
    ),
  ];

  void _onCardTap(int index) {
    setState(() {
      _expandedIndex = (_expandedIndex == index) ? null : index;
    });
  }

  void _onPurchase(RewardItem reward) {
    if (widget.userPoints < reward.points) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Not enough points',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          ),
          content: Text(
            'You need ${reward.points} pts to redeem "${reward.title}" but you only have ${widget.userPoints} pts.',
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF00C2A8),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Redeem "${reward.title}"?',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: Text(
          'This will use ${reward.points} pts from your balance.',
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C2A8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              // TODO: API call / deduct points
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '"${reward.title}" redeemed successfully!',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  backgroundColor: const Color(0xFF00C2A8),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Stack(
        children: [
          // ===== เนื้อหาหลัก =====
          SafeArea(
            child: Column(
              children: [
                // Title กลาง
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Center(
                    child: Text(
                      'Rewards',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5C5454),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                // ===== Reward Cards =====
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                    itemCount: _rewards.length,
                    itemBuilder: (context, index) {
                      final reward = _rewards[index];
                      final isExpanded = _expandedIndex == index;
                      return _buildRewardCard(reward, index, isExpanded);
                    },
                  ),
                ),
              ],
            ),
          ),

          // ===== ปุ่ม Back =====
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(RewardItem reward, int index, bool isExpanded) {
    final isPressed = _pressedIndex == index;
    return GestureDetector(
      onTap: () => _onCardTap(index),
      onTapDown: (_) => setState(() => _pressedIndex = index),
      onTapUp: (_) async {
        await Future.delayed(const Duration(milliseconds: 150));
        if (mounted) setState(() => _pressedIndex = null);
      },
      onTapCancel: () => setState(() => _pressedIndex = null),
      child: AnimatedScale(
        scale: isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isPressed ? 0.03 : 0.06),
                blurRadius: isPressed ? 6 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Collapsed ===
              if (!isExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      reward.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: reward.titleColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '${reward.points} pts',
                      style: TextStyle(
                        fontSize: 13,
                        color: reward.previewTextColor ?? const Color(0xFF00C2A8),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

              // === Expanded ===
              if (isExpanded) ...[
                Center(
                  child: Text(
                    reward.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: reward.titleColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 14)),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(
                              text: reward.description,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: '\n(${reward.descriptionTh})'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (reward.previewText != null) ...[
                  Center(
                    child: Text(
                      reward.previewText!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: reward.previewTextColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${reward.points} pts',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _onPurchase(reward),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C2A8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Purchase',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        ),
      ),
    );
  }
}