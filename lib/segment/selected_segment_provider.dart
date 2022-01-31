import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/segment/segment.dart';

final selectedSegmentStateProvider =
    StateNotifierProvider<SelectedSegmentState, Segment?>((ref) {
  final SelectedSegmentState selectedSegmentState = SelectedSegmentState();
  return selectedSegmentState;
});

class SelectedSegmentState extends StateNotifier<Segment?> {
  SelectedSegmentState() : super(null);

  void selectSegment(Segment segment) {
    state = segment;
  }
}
