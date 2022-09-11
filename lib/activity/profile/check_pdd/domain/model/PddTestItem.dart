
class PddTestItem {
  late String? imageSource;
  late String question;
  late List<PddTestOption> options;

  PddTestItem(this.question, this.imageSource, this.options);
}

class PddTestOption {
  late bool isCorrect;
  late String label;

  PddTestOption(this.label, [this.isCorrect = false]);
}
