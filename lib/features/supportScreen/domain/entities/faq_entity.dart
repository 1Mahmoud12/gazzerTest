import 'package:equatable/equatable.dart';

class FaqCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String type;
  final String? typeOrderIssue;
  final int? parentId;
  final int order;
  final bool isActive;
  final bool hasChildren;
  final bool hasQuestions;
  final List<FaqCategoryEntity> children;
  final List<FaqQuestionEntity> questions;

  const FaqCategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.typeOrderIssue,
    required this.type,
    this.parentId,
    required this.order,
    required this.isActive,
    required this.hasChildren,
    required this.hasQuestions,
    required this.children,
    required this.questions,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    parentId,
    order,
    isActive,
    hasChildren,
    hasQuestions,
    children,
    questions,
  ];
}

class FaqQuestionEntity extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int categoryId;
  final int order;
  final bool isActive;

  const FaqQuestionEntity({
    required this.id,
    required this.question,
    required this.answer,
    required this.categoryId,
    required this.order,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    id,
    question,
    answer,
    categoryId,
    order,
    isActive,
  ];
}
