import 'reward_service.dart';

class PointEngine {
  final RewardService rewardService =
  RewardService();

  Future<void> givePoint(
      String status,
      ) async {
    switch (status) {
      case "Belum Lancar":
        await rewardService.addPoint(
          point: 1,
          title: "Belum Lancar",
          description:
          "Tetap semangat belajar.",
        );
        break;

      case "Cukup":
        await rewardService.addPoint(
          point: 3,
          title: "Cukup",
          description:
          "Perkembangan mulai terlihat.",
        );
        break;

      case "Lancar":
        await rewardService.addPoint(
          point: 5,
          title: "Lancar",
          description:
          "Target berhasil diselesaikan.",
        );
        break;

      case "Mutqin":
        await rewardService.addPoint(
          point: 10,
          title: "Mutqin",
          description:
          "Target dikuasai dengan sangat baik.",
        );
        break;
    }
  }
}