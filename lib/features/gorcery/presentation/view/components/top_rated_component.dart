part of '../grocery_screen.dart';

class _TopRatedComponent extends StatelessWidget {
  const _TopRatedComponent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        children: [
          TitleWithMore(title: "Top rated", onPressed: () {}),

          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Fakers.vendors.length,

              itemBuilder: (context, index) {
                return;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: Grad.bglightLinear,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipOval(
              child: AspectRatio(aspectRatio: 1, child: Image.asset(Assets.assetsPngGroceryAdd, fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }
}
