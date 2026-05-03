import 'package:flutter/material.dart';
import 'timeline_card.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  static const List<ElectionStep> _steps = [
    ElectionStep(
      title: 'Voter Registration',
      description: 'Ensure you are registered to vote at your current address. Check deadlines for your state.',
      date: 'Oct 7, 2024',
    ),
    ElectionStep(
      title: 'Request Mail-In Ballot',
      description: 'If you plan to vote by mail, request your absentee ballot early.',
      date: 'Oct 15, 2024',
    ),
    ElectionStep(
      title: 'Early Voting Begins',
      description: 'Take advantage of early voting periods to avoid lines on Election Day. Check local polling locations and hours.',
      date: 'Oct 20, 2024',
    ),
    ElectionStep(
      title: 'Election Day',
      description: 'Polls open! Bring necessary identification if required by your state. Cast your vote!',
      date: 'Nov 5, 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      itemCount: _steps.length,
      itemBuilder: (context, index) {
        return TimelineCard(
          step: _steps[index],
          index: index,
        );
      },
    );
  }
}
