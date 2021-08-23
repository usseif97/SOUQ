import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/cubit/home_states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).homeModel;
        var favouritesList =
            model!.data.products.where((i) => i.inFavorites).toList();

        return favouritesList.length != 0
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'FAVOURITES',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          productBuilder(favouritesList[index], context),
                      itemCount: favouritesList.length,
                    )
                  ],
                ),
              )
            : Center(
                child: Text(
                  'No Products',
                  style: TextStyle(fontSize: 36.0),
                ),
              );
      },
    );
  }
}
