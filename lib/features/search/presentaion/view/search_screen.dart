import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_back_icon.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_cubit.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_states.dart';
import 'package:gazzer/features/search/presentaion/view/components/search_categories_component.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/filter_widget.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/search_vendor_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const route = '/search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCubit cubit;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<SearchCubit>();
    cubit.loadCategories();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (previous, current) => current is LoadCategoriesState || previous is LoadCategoriesState,
            builder: (context, state) => Column(
              spacing: 10,
              children: [
                Row(
                  children: [
                    const MainBackIcon(),
                    BlocBuilder<SearchCubit, SearchState>(
                      buildWhen: (previous, current) => current is SearchLoading,
                      builder: (context, state) => (cubit.state.query.searchWord.isNotEmpty)
                          ? RichText(
                              text: TextSpan(
                                text: L10n.tr().searchFor,
                                style: context.style16400.copyWith(fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: ' ${cubit.state.query.searchWord.trim()}',
                                    style: context.style16400.copyWith(color: Co.purple, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                Hero(
                  tag: Tags.searchBar,
                  child: MainTextField(
                    controller: cubit.controller,
                    height: 80,
                    autofocus: true,
                    borderRadius: 64,
                    action: TextInputAction.done,
                    hintText: L10n.tr().enterThreeLetterOrMore,
                    bgColor: Colors.transparent,
                    prefixOnTap: () {
                      if (cubit.controller.text == cubit.state.query.searchWord) {
                        return;
                      }
                      cubit.performSearch(cubit.state.query.copyWith(searchWord: cubit.controller.text));
                    },
                    prefix: const Icon(Icons.search, size: 24),
                    onSubmitting: (p0) {
                      if (p0 == cubit.state.query.searchWord) return;
                      cubit.performSearch(cubit.state.query.copyWith(searchWord: p0));
                    },
                  ),
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) => current is LoadCategoriesState,
                  builder: (context, state) => Skeletonizer(
                    enabled: state is LoadCategoriesLoading,
                    child: SearchCategoriesComponent(
                      onTap: (id) {
                        if (id == cubit.state.query.categoryId) return;
                        cubit.performSearch(cubit.state.query.copyWith(categoryId: id));
                      },
                      initIndex: state is LoadCategoriesState
                          ? (cubit.state.query.categoryId == null
                                ? -1
                                : state.categories.indexWhere((element) => element.id == cubit.state.query.categoryId))
                          : -1,
                      categories: state is LoadCategoriesState ? state.categories : [],
                    ),
                  ),
                ),

                ///
                const FilterWidget(),

                ///
                BlocConsumer<SearchCubit, SearchState>(
                  listener: (context, state) {},
                  buildWhen: (previous, current) => current is SearchResultsStates || current is LoadMoreResults,
                  builder: (context, state) {
                    if (state is SearchError) {
                      return FailureComponent(
                        message: L10n.tr().unableToLoadResultsPleaseTryAgainLater,
                        onRetry: () => cubit.performSearch(cubit.state.query),
                      );
                    } else if (state is SearchSuccess && state.vendors.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            state.query.searchWord.trim().isEmpty
                                ? L10n.tr().enterTheWordYouWantToSearchFor
                                : L10n.tr().noResultsFoundTryAdjustingYourFilter,
                            style: context.style16500.copyWith(color: Co.darkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (state is LoadMoreResultsLoading) return true;
                          if (notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.9) {
                            if (cubit.currentPage < cubit.lastPage) {
                              cubit.loadMoreResults();
                            }
                          }
                          return true;
                        },
                        child: Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          child: Skeletonizer(
                            enabled: state is SearchLoading,
                            child: ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.vendors.length + 1,
                              separatorBuilder: (context, index) => const VerticalSpacing(12),
                              itemBuilder: (context, index) {
                                if (index == state.vendors.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: state is! LoadMoreResultsLoading
                                        ? const SizedBox.shrink()
                                        : LinearProgressIndicator(borderRadius: AppConst.defaultInnerBorderRadius, minHeight: 6, color: Co.secondary),
                                  );
                                }
                                return SearchVendorWidget(vendor: state.vendors[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
