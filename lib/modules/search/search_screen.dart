import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/models/search_model.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/search_cubit.dart';
import 'package:souq/shared/cubit/search_states.dart';
import 'package:souq/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }

                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        context: context,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState ||
                          state is SearchSuccessChangeFavouritesState ||
                          state is SearchSuccessChangeCartState)
                        SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data
                                    .length !=
                                0
                            ? Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) =>
                                      _searcProductBuilder(
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data[index],
                                    context,
                                  ),
                                  itemCount: SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data
                                      .length,
                                ),
                              )
                            : Text('No Products'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _searcProductBuilder(Product model, BuildContext context) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: model.image != null
                                ? NetworkImage(model.image)
                                : NetworkImage(
                                    'https://i.stack.imgur.com/mwFzF.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            model.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${model.price}\$',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
