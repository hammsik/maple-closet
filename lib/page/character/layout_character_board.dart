import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maple_closet/data/backgrounds.dart';
import 'package:maple_closet/providers/setting_provider.dart';

class CharacterBoard extends HookConsumerWidget {
  final double height;

  const CharacterBoard({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBackgroundType = ref.watch(backgroundSettingProvider);

    // AnimationController 생성
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    // CurvedAnimation 생성
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuart,
    );

    final sizeAnimation = Tween<Size>(
      begin: Size(MediaQuery.sizeOf(context).width, height),
      end: Size(MediaQuery.sizeOf(context).width - 200, height),
    ).animate(curvedAnimation);

    useEffect(() {
      print('currentBackgroundType: $currentBackgroundType');
      if (currentBackgroundType == BackgroundType.basic) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [currentBackgroundType]);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: currentBackgroundType == BackgroundType.basic
          ? Row(
              children: [
                AnimatedBuilder(
                  animation: sizeAnimation,
                  builder: (context, child) {
                    return SizedBox(
                      width: sizeAnimation.value.width,
                      height: sizeAnimation.value.height,
                      child: child,
                    );
                  },
                  child: Animate(
                    effects: [FadeEffect(curve: Curves.easeInQuint)],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: const Color.fromARGB(255, 230, 222, 218),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: imageMap.entries
                        .map((type) => ElevatedButton(
                            onPressed: () => ref
                                .read(imageSettingProvider.notifier)
                                .changeImageType(type.key),
                            child: Text(type.value)))
                        .toList()
                        .animate(delay: 200.ms, interval: 50.ms)
                        .fadeIn(curve: Curves.easeInQuint, duration: 150.ms)
                        .moveX(
                          begin: 50,
                          curve: Curves.easeOutQuart,
                          duration: 300.ms,
                        ),
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                fit: BoxFit.fitHeight,
                backgroundMap[currentBackgroundType]![1],
              ),
            ),
    );
  }
}
