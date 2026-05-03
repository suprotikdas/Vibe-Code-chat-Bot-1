import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../roadmap/roadmap_view.dart';
import '../chat/chat_panel.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoterFlow Web'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Chip(
              label: const Text('Gemini Powered'),
              backgroundColor: AppTheme.surface,
              side: const BorderSide(color: AppTheme.border),
              labelStyle: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
              avatar: const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 16),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint for switching layouts
          if (constraints.maxWidth > 800) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return const Row(
      children: [
        Expanded(
          flex: 3,
          child: RoadmapView(),
        ),
        Expanded(
          flex: 2,
          child: ChatPanel(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        const RoadmapView(),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: const ChatPanel(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.chat),
            label: const Text('Ask Concierge'),
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
