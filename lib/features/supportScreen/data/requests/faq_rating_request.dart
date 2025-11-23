class FaqRatingRequest {
  final int rating;
  final int faqQuestionId;
  final int? faqCategoryId;
  final String? feedback;

  FaqRatingRequest({
    required this.rating,
    required this.faqQuestionId,
    this.faqCategoryId,
    this.feedback,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'faq_question_id': faqQuestionId,
      if (faqCategoryId != null) 'faq_category_id': faqCategoryId,
      if (feedback != null && feedback!.isNotEmpty) 'feedback': feedback,
    };
  }
}
