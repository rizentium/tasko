extension NullableString on String? {
  bool get isUndefined {
    if (this == null) {
      return true;
    }

    if (this == '') {
      return true;
    }

    return false;
  }
}
