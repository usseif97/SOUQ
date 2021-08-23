import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/models/categories_data_model.dart';
import 'package:souq/models/categories_model.dart';
import 'package:souq/models/home_model.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/cubit/home_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.homeModel != null && cubit.categoriesModel != null
            ? _productsBuilder(cubit.homeModel, cubit.categoriesModel)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _productsBuilder(HomeModel? model, CategoriesModel? categoriesModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map((element) => _bannerBuilder(element))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.7,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Text(
                'CATEGORIES',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              height: 180,
              child: ListView.builder(
                itemBuilder: (context, index) => _categoryBuilder(
                    categoriesModel!.data.data[index], context),
                itemCount: categoriesModel!.data.data.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Text(
                'PRODUCTS',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  productBuilder(model.data.products[index], context),
              itemCount: model.data.products.length,
            ),
          ],
        ),
      );

  Widget _bannerBuilder(dynamic element) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${element.image}'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 10.0,
              ),
            ],
          ),
        ),
      );

  Widget _categoryBuilder(DataModel model, BuildContext context) => InkWell(
        onTap: () {
          HomeCubit.get(context).changeIndex(1);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: 150.0,
                height: 180.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(model.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
                width: 150.0,
                child: Text(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
