import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/cubits/favorite_cubit/cubit.dart';
import '../../../core/controllers/cubits/favorite_cubit/state.dart';
import '../../widgets/build_product_item.dart';
import '../../widgets/check_out.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FavoriteCubit.get(context);
        final Size size = MediaQuery.of(context).size;

        if (cubit.favoritesModel == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body:SingleChildScrollView(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                child: GridView.count(
                  childAspectRatio: 1 / 1.6,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                      cubit.favoritesModel!.favoriteProducts!.length,
                          (index) =>
                          buildProductItem(cubit.favoritesModel!
                              .favoriteProducts![index],context)),
                ),
              ),
              if (cubit.favoritesModel!.favoriteProducts!.isEmpty)
                const Center(
                  child: Text(
                    'Cart Is Empty',
                  ),
                ),
            ],
          ),),
        );
      },
    );
  }
}
