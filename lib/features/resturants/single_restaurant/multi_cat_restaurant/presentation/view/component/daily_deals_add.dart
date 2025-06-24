part of '../multi_cat_restaurant_screen.dart';

class DailyDealsAdd extends StatefulWidget {
  const DailyDealsAdd({super.key});

  @override
  State<DailyDealsAdd> createState() => _DailyDealsAddState();
}

class _DailyDealsAddState extends State<DailyDealsAdd> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: Stack(
        children: [
          SizedBox.expand(child: Image.asset(Assets.assetsPngDailyDealsAdd, fit: BoxFit.cover)),
          Align(
            alignment: const Alignment(-0.95, -1),
            child: Image.asset(Assets.assetsPngShawerma, fit: BoxFit.cover, height: 125),
          ),
          Align(
            alignment: const Alignment(1, 0),
            child: SlideTimer(duration: const Duration(seconds: 1), startTime: DateTime.now().add(const Duration(hours: 1))),
          ),
        ],
      ),
    );
  }
}
