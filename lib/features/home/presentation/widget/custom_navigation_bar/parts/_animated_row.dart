part of '../animated_bottom_bar.dart';

class _AnimatedRow extends StatefulWidget {
  const _AnimatedRow({
    super.key,
    this.initialItemCount = 0,
    required this.itemBuilder,
  });

  final int initialItemCount;
  final Widget Function(BuildContext context, int index, Animation<double> animation) itemBuilder;

  @override
  State<_AnimatedRow> createState() => _AnimatedRowState();
}

class _AnimatedRowState extends State<_AnimatedRow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _itemsCount;
  int? _newItemIndex;

  Animation<double> get _completedAnimation => Tween<double>(end: 1.0, begin: 1.0).animate(_controller);

  void insertItem(int index) {
    _itemsCount++;
    _newItemIndex = index;
    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.initialItemCount;
    _controller = AnimationController(duration: const Duration(milliseconds: 330), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _itemsCount,
            (index) {
          if (_newItemIndex == index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Expanded(
                flex: (100 * _controller.value).round(),
                child: widget.itemBuilder(context, index, _controller),
              ),
            );
          } else {
            return Expanded(
              flex: 100,
              child: widget.itemBuilder(context, index, _completedAnimation),
            );
          }
        },
      ),
    );
  }
}

class _RowModel<E> {
  _RowModel({
    required this.listKey,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<_AnimatedRowState> listKey;
  final List<E> _items;

  _AnimatedRowState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    if (!_items.contains(item)) {
      _items.insert(index, item);
      _animatedList!.insertItem(index);
    }
  }

  bool contains(E e) => _items.contains(e);

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
