/// A model class used to represent a selectable item.
class MultiSelectItem<T> {
  final T value;
  final String label;

  MultiSelectItem(this.value, this.label);

  MultiSelectItem.fromOther(MultiSelectItem<T> other)
      : value = other.value,
        label = other.label;
}
