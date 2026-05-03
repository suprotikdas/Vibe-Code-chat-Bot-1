import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ElectionStep {
  final String title;
  final String description;
  final String date;

  const ElectionStep({
    required this.title,
    required this.description,
    required this.date,
  });
}

class TimelineCard extends StatefulWidget {
  final ElectionStep step;
  final int index;
  final VoidCallback? onTap;

  const TimelineCard({
    super.key,
    required this.step,
    required this.index,
    this.onTap,
  });

  @override
  State<TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Election Step ${widget.index + 1}: ${widget.step.title}',
      hint: widget.step.description,
      button: widget.onTap != null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.diagonal3Values(
              _isHovered ? 1.02 : 1.0,
              _isHovered ? 1.02 : 1.0,
              1.0,
            ),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: _isHovered ? AppTheme.background : AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? AppTheme.primary.withValues(alpha: 0.5) : AppTheme.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _isHovered ? 0.1 : 0.05),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepIndicator(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.step.date,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.step.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.step.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _isHovered ? AppTheme.primary : AppTheme.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.primary,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '${widget.index + 1}',
          style: TextStyle(
            color: _isHovered ? Colors.white : AppTheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
