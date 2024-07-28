class Fatwa {
  final String title;
  final String chapter;
  final String question;
  final String answer;

  Fatwa({
    required this.title,
    required this.chapter,
    required this.question,
    required this.answer,
  });

  factory Fatwa.fromJson(Map<String, dynamic> json) {
    return Fatwa(
      title: json['title'],
      chapter: json['chapter'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}