import 'package:flutter/material.dart';

import '../models/reward.dart';
import '../services/reward_service.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() =>
      _RewardScreenState();
}

class _RewardScreenState
    extends State<RewardScreen> {

  final RewardService service =
  RewardService();

  List<Reward> rewards = [];

  int totalPoint = 0;

  @override
  void initState() {
    super.initState();

    loadRewards();
  }

  Future<void> loadRewards() async {
    final result =
    await service.getAll();

    final point =
    await service.getTotalPoint();

    if (!mounted) return;

    setState(() {
      rewards = result;
      totalPoint = point;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reward",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Card(
            margin:
            const EdgeInsets.all(16),
            child: ListTile(
              leading: const Icon(
                Icons.stars,
                color: Colors.amber,
              ),
              title: const Text(
                "Total Poin",
              ),
              subtitle: Text(
                "$totalPoint poin",
              ),
            ),
          ),

          Expanded(
            child: rewards.isEmpty
                ? const Center(
              child: Text(
                "Belum ada reward.",
              ),
            )
                : ListView.builder(
              itemCount:
              rewards.length,
              itemBuilder:
                  (context, index) {
                final reward =
                rewards[index];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.card_giftcard,
                      color:
                      Colors.green,
                    ),
                    title: Text(
                      reward.title,
                    ),
                    subtitle: Text(
                      reward.description,
                    ),
                    trailing: Text(
                      "+${reward.point}",
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}