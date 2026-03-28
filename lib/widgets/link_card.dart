import 'package:flutter/material.dart';
import '../models/link_model.dart';
import '../utils/constants.dart';

class LinkCard extends StatefulWidget {
  final LinkModel link;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const LinkCard({
    super.key,
    required this.link,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppDurations.animationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconForUrl(widget.link.url),
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.link.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForUrl(String url) {
    String domain = url.toLowerCase();

    if (domain.contains('youtube') || domain.contains('youtu.be')) {
      return Icons.play_circle_fill;
    } else if (domain.contains('twitter') || domain.contains('x.com')) {
      return Icons.chat_bubble;
    } else if (domain.contains('facebook') || domain.contains('fb.com')) {
      return Icons.facebook;
    } else if (domain.contains('instagram')) {
      return Icons.camera_alt;
    } else if (domain.contains('github')) {
      return Icons.code;
    } else if (domain.contains('linkedin')) {
      return Icons.work;
    } else if (domain.contains('gmail') || domain.contains('mail.google')) {
      return Icons.email;
    } else if (domain.contains('google')) {
      return Icons.search;
    } else if (domain.contains('amazon')) {
      return Icons.shopping_cart;
    } else if (domain.contains('netflix') ||
        domain.contains('prime') ||
        domain.contains('disney')) {
      return Icons.movie;
    } else if (domain.contains('reddit')) {
      return Icons.forum;
    } else if (domain.contains('whatsapp')) {
      return Icons.message;
    } else if (domain.contains('telegram')) {
      return Icons.send;
    } else if (domain.contains('discord')) {
      return Icons.headset_mic;
    } else if (domain.contains('spotify')) {
      return Icons.music_note;
    } else if (domain.contains('news') ||
        domain.contains('medium') ||
        domain.contains('blog')) {
      return Icons.article;
    }

    return Icons.language;
  }
}
