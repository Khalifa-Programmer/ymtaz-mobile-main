import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/learning_path/data/models/book_details_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_state.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/spacing.dart';

class BookDetailsPage extends StatefulWidget {
  List<ItemDetails> items;
  int currentIndex;
  final int pathId;

  BookDetailsPage({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.pathId,
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late LearningPathCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<LearningPathCubit>();
    _loadBookDetails();
  }

  void _loadBookDetails() {
    _cubit.getBookDetails(widget.items[widget.currentIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Builder(
        builder: (context) {
          return BlocConsumer<LearningPathCubit, LearningPathState>(
            listenWhen: (previous, current) => 
              current is ReadingStateSuccess || 
              current is ReadingStateError ||
              current is FavouriteSuccess ||
              current is FavouriteError,
            buildWhen: (previous, current) => 
              current is BookDetailsLoading ||
              current is BookDetailsLoaded ||
              current is BookDetailsError,
            listener: (context, state) {
              if (state is ReadingStateSuccess) {
                setState(() {
                  widget.items[widget.currentIndex].alreadyDone = true;
                  if (widget.currentIndex + 1 < widget.items.length) {
                    widget.items[widget.currentIndex + 1].locked = false;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );

                if (widget.currentIndex + 1 < widget.items.length) {
                  setState(() {
                    widget.currentIndex++;
                    _loadBookDetails();
                  });
                }
              }

              if (state is ReadingStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is FavouriteSuccess) {
                setState(() {
                  widget.items[widget.currentIndex].isFavourite = state.isFavourite;
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }

              if (state is FavouriteError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is BookDetailsLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final book = _cubit.book;
              if (book == null) {
                return const Scaffold(
                  body: Center(child: Text('لا توجد تفاصيل متاحة')),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    book.name,
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.black,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(20.h),
                      SvgPicture.asset(
                        AppAssets.logo,
                        color: appColors.primaryColorYellow,
                        width: 40.w,
                        height: 40.w,
                      ),
                      verticalSpace(10.h),
                      _buildBookContent(book),

                    ],
                  ),
                ),
                bottomNavigationBar: _buildNavigationButtons(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBookContent(BookDetails book) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 9,
            offset: const Offset(3, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                book.name,
                style: const TextStyle(
                  color: appColors.blue100,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.copy_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: """
📚 يمتاز | المكتبة القانونية
•⁠  ⁠اسم الكتاب: ${book.name}
•⁠  ⁠المحتوى: ${book.sectionText}

⏳ تصفح تطبيق يمتاز الآن :
https://onelink.to/bb6n4x"""));
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.share_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  Share.share(
                    """
📚 يمتاز | المكتبة القانونية

•⁠  ⁠اسم الكتاب: ${book.name}
•⁠  ⁠المحتوى: ${book.sectionText}

⏳ تصفح تطبيق يمتاز الآن :
https://onelink.to/bb6n4x""",
                    subject: 'يمتاز',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                  );
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.translate_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: appColors.grey1,
              border: Border.all(color: appColors.grey2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                    color: appColors.blue100,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  book.sectionText,
                  style: const TextStyle(
                    color: appColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return BottomAppBar(
      color: appColors.grey1,
      surfaceTintColor: appColors.grey1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.currentIndex > 0
                ? () {
                    setState(() {
                      widget.currentIndex--;
                      _loadBookDetails();
                    });
                  }
                : null,
          ),
          BlocBuilder<LearningPathCubit, LearningPathState>(
            buildWhen: (previous, current) => 
              current is FavouriteLoading || 
              current is FavouriteSuccess || 
              current is FavouriteError,
            builder: (context, state) {
              final bool isFavourite = widget.items[widget.currentIndex].isFavourite;
              final bool isLoading = state is FavouriteLoading;
              
              return IconButton(
                icon: isLoading 
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
                      ),
                    )
                  : Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? appColors.primaryColorYellow : null,
                    ),
                onPressed: isLoading
                  ? null
                  : () {
                      _cubit.toggleFavourite(
                        widget.items[widget.currentIndex].learningPathItemId,
                        isFavourite,
                      );
                    },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: (widget.currentIndex < widget.items.length - 1 &&
                    !widget.items[widget.currentIndex + 1].locked)
                ? () {
                    setState(() {
                      widget.currentIndex++;
                      _loadBookDetails();
                    });
                  }
                : null,
          ),
          BlocBuilder<LearningPathCubit, LearningPathState>(
            builder: (context, state) {
              final bool isAlreadyRead = widget.items[widget.currentIndex].alreadyDone;
              
              return IconButton(
                icon: state is ReadingStateLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      )
                    : Icon(
                        Icons.check,
                        color: isAlreadyRead ? appColors.grey3 : null,
                      ),
                onPressed: (state is ReadingStateLoading || isAlreadyRead)
                    ? null
                    : () {
                        _cubit.markAsRead(
                          widget.items[widget.currentIndex].learningPathItemId,
                          widget.items[widget.currentIndex].learningPathItemId,
                          widget.currentIndex,
                        );
                      },
              );
            },
          ),
        ],
      ),
    );
  }
} 
