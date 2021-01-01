mixin FormMixin {
  final Map<String, bool> validInputsMap = {};
  final double formCompletion = 0;
  final bool isFormErrorVisible = false;

  void onItemValidate(String name, bool isValid, {String value});
  void onItemChange(String name, String value);

  int countValidItems() {
    int count = 0;
    validInputsMap.forEach((name, isValid) {
      if (isValid) count++;
    });
    return count;
  }
}
