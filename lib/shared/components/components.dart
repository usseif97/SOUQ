import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souq/models/product_model.dart';
import 'package:souq/shared/cubit/home_cubit.dart';
import 'package:souq/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
          ),
        ],
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultColoredButton({
  required String text,
  Function? onTap,
}) =>
    InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text.toUpperCase(),
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
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  double radius = 10.0,
  bool isClickable = true,
  bool showKeyboard = true,
  required BuildContext context,
}) =>
    TextFormField(
      style: Theme.of(context).textTheme.bodyText2,
      showCursor: !showKeyboard,
      readOnly: !showKeyboard,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        if (onSubmit != null) onSubmit(s);
      },
      onChanged: (s) {
        if (onChange != null) onChange(s);
      },
      onTap: () {
        if (onTap != null) onTap();
      },
      validator: (s) {
        return validate(s);
      },
      decoration: InputDecoration(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.normal),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget defaultSeperator() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[400],
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

enum snackBarStates { SUCCESS, ERROR, WARNING }
Color snackBarColor(snackBarStates state) {
  Color color;
  switch (state) {
    case snackBarStates.SUCCESS:
      color = Colors.green;
      break;
    case snackBarStates.ERROR:
      color = Colors.red;
      break;
    case snackBarStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void showSnackBar({
  required BuildContext context,
  required String? content,
  required String label,
  required snackBarStates state,
  Function? onpressed,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackBarColor(state),
        content: Text(content!),
        action: SnackBarAction(
          label: label,
          onPressed: () {
            if (onpressed != null) onpressed();
          },
          textColor: Colors.white,
        ),
      ),
    );

Widget productBuilder(ProductModel model, BuildContext context) => InkWell(
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
                    if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white),
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
                        Row(
                          children: [
                            Text(
                              '${model.price}\$',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (model.discount != 0)
                              Text(
                                '${model.oldPrice}\$',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (HomeCubit.get(context).favourites != null)
                              IconButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .changeFavourites(model.id);
                                },
                                icon: CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor: HomeCubit.get(context)
                                          .favourites![model.id]!
                                      ? defaultColor
                                      : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            if (HomeCubit.get(context).favourites == null)
                              IconButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .changeFavourites(model.id);
                                },
                                icon: CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                          ],
                        ),
                        if (HomeCubit.get(context).carts != null)
                          InkWell(
                            onTap: () {
                              HomeCubit.get(context).changeCart(model.id);
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    HomeCubit.get(context).carts![model.id]!
                                        ? 'REMOVE FROM CART'
                                        : 'ADD TO CART',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                    Colors.red,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        if (HomeCubit.get(context).carts == null)
                          InkWell(
                            onTap: () {
                              HomeCubit.get(context).changeCart(model.id);
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                    Colors.red,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
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
