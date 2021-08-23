import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/cubit/home_states.dart';
import 'package:souq/shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).homeModel;
        var cartList = model!.data.products.where((i) => i.inCart).toList();
        dynamic total = 0;
        cartList.forEach((element) {
          total += element.price;
        });

        return cartList.length != 0
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
                        'MY CART',
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
                          productBuilder(cartList[index], context),
                      itemCount: cartList.length,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'TOTAL: $total\$',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              defaultColor,
                              Colors.green,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
