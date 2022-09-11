class CheckPddResult implements Comparable {

  int correctAnswerNumber;
  int questionsNumber;

  CheckPddResult(this.correctAnswerNumber, this.questionsNumber);


  @override
  String toString() {
    return ("${correctAnswerNumber}/${questionsNumber}");
  }

  @override
  int compareTo(other) {
    return (correctAnswerNumber/questionsNumber)
        .compareTo(other.correctAnswerNumber/other.questionsNumber);
  }
}