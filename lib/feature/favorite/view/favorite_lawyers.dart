import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/favorite/logic/favorite_cubit.dart';
import 'package:yamtaz/feature/favorite/logic/favorite_state.dart';

import '../../../config/themes/styles.dart';
import '../../../core/di/dependency_injection.dart';

class FavoriteLawyersScreen extends StatelessWidget {
  const FavoriteLawyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المفضلة',
          style: TextStyles.cairo_14_bold,
        ),
      ),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: getit<FavoriteCubit>().favoriteResponseModel == null,
            builder: (context) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            fallback: (context) => getit<FavoriteCubit>()
                    .favoriteResponseModel!
                    .data!
                    .favouriteLawyers!
                    .isEmpty
                ? const Center(
                    child: Text('لا يوجد مفضلة'),
                  )
                : ListView.builder(
                    itemCount: getit<FavoriteCubit>()
                        .favoriteResponseModel!
                        .data!
                        .favouriteLawyers!
                        .length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(getit<FavoriteCubit>()
                              .favoriteResponseModel!
                              .data!
                              .favouriteLawyers![index]
                              .favLawyer!
                              .name ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              getit<FavoriteCubit>().addLawyerToFavorite(
                                  getit<FavoriteCubit>()
                                      .favoriteResponseModel!
                                      .data!
                                      .favouriteLawyers![index]
                                      .favLawyer!
                                      .id!
                                      .toString());
                            },
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(getit<FavoriteCubit>()
                                .favoriteResponseModel!
                                .data!
                                .favouriteLawyers![index]
                                .favLawyer!
                                .logo!),
                          ));
                    }),
          );
        },
      ),
    );
  }
}
