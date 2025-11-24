import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';

class FaqCategoryDTO {
  final int id;
  final String name;
  final String? description;
  final String? typeOrderIssue;
  final String type;
  final int? parentId;
  final int order;
  final bool isActive;
  final bool hasChildren;
  final bool hasQuestions;
  final List<FaqCategoryDTO> children;
  final List<FaqQuestionDTO> questions;

  FaqCategoryDTO({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    this.typeOrderIssue,
    this.parentId,
    required this.order,
    required this.isActive,
    required this.hasChildren,
    required this.hasQuestions,
    required this.children,
    required this.questions,
  });

  factory FaqCategoryDTO.fromJson(Map<String, dynamic> json) {
    return FaqCategoryDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      typeOrderIssue: json['order_issue_type'] as String?,
      parentId: json['parent_id'] as int?,
      order: json['order'] as int,
      isActive: json['is_active'] as bool,
      hasChildren: json['has_children'] as bool,
      hasQuestions: json['has_questions'] as bool,
      children: (json['children'] as List<dynamic>?)?.map((child) => FaqCategoryDTO.fromJson(child as Map<String, dynamic>)).toList() ?? [],
      questions: (json['questions'] as List<dynamic>?)?.map((question) => FaqQuestionDTO.fromJson(question as Map<String, dynamic>)).toList() ?? [],
    );
  }

  FaqCategoryEntity toEntity() {
    return FaqCategoryEntity(
      id: id,
      name: name,
      description: description,
      type: type,
      parentId: parentId,
      typeOrderIssue: typeOrderIssue,
      order: order,
      isActive: isActive,
      hasChildren: hasChildren,
      hasQuestions: hasQuestions,
      children: children.map((child) => child.toEntity()).toList(),
      questions: questions.map((question) => question.toEntity()).toList(),
    );
  }
}

class FaqQuestionDTO {
  final int id;
  final String question;
  final String answer;
  final int categoryId;
  final int order;
  final bool isActive;

  FaqQuestionDTO({
    required this.id,
    required this.question,
    required this.answer,
    required this.categoryId,
    required this.order,
    required this.isActive,
  });

  factory FaqQuestionDTO.fromJson(Map<String, dynamic> json) {
    return FaqQuestionDTO(
      id: json['id'] as int,
      question: json['question'] as String,
      answer: json['answer'] as String,
      categoryId: json['category_id'] as int,
      order: json['order'] as int,
      isActive: json['is_active'] as bool,
    );
  }

  FaqQuestionEntity toEntity() {
    return FaqQuestionEntity(
      id: id,
      question: question,
      answer: answer,
      categoryId: categoryId,
      order: order,
      isActive: isActive,
    );
  }
}
