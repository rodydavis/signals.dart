import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class UpdateNotice extends StatefulWidget {
  @override
  State<UpdateNotice> createState() => _UpdateNoticeState();

  final dynamic signalObject;

  const UpdateNotice({super.key, required this.signalObject});
}

class _UpdateNoticeState extends State<UpdateNotice>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  EffectCleanup? _cleanup;

  bool hit() {
    controller.value = 0.0;
    controller.animateTo(1.0);
    return true;
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _cleanup = effect(() => (widget.signalObject.value != null) && hit());
    super.initState();
  }

  @override
  void dispose() {
    _cleanup?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        width: 30,
        height: 30,
        color: Color.lerp(
            const Color(0xffff662a), const Color(0x00ff662a), controller.value),
        child: Center(
            child: Text(
          '＊',
          style: TextStyle(
            color: Color.lerp(
                Colors.white, const Color(0x00ffffff), controller.value),
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        )),
      ),
    );
  }
}
