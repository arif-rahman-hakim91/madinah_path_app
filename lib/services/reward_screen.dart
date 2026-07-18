import 'package:flutter/material.dart';

import '../models/reward.dart';
import '../repositories/reward_repository.dart';
import '../services/current_child_service.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final repository = RewardRepository();

  late Future<List<Reward>> rewards;

  int totalPoint = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final child = CurrentChildService.currentChild;

    if (child == null) {
      rewards = Future.value([]);
      return;
    }

    rewards = repository.getAll(child.id!);

    totalPoint =
    await repository.getTotalPoint(child.id!);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.amber,
                    size: 60,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Total Point",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    "$totalPoint",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Reward>>(
              future: rewards,
              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada reward.",
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {

                    final reward = data[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),

                      title: Text(reward.title),

                      subtitle: Text(
                        reward.description,
                      ),

                      trailing: Text(
                        "+${reward.point}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}