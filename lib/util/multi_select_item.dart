/// A model class used to represent a selectable item.
class MultiSelectItem<T> {
  final T value;
  final String label;
  bool selected;

  MultiSelectItem(this.value, this.label, {this.selected = false});

  MultiSelectItem.fromOther(MultiSelectItem<T> other)
      : value = other.value,
        label = other.label,
        selected = other.selected;
}
