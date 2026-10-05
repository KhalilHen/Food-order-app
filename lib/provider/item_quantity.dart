import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemQuantity extends Notifier<int> {
  @override
  int build() {
    // TODO Mabye let it be default 1
    return 0;
  }

  void updateQuantity() {
    state++;
  }

  void decreaseQuantity() {
    if (state > 0) {
      state--;
    }
  }

  int itemValue() {
    return state;
  }
}

final itemQuantityProvider = NotifierProvider.family
    .autoDispose<ItemQuantity, int, int>((ref) {
      return ItemQuantity();
    });


