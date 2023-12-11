import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/favorite_cubit/state.dart';

import '../../../../models/change_favorite_model.dart';
import '../../../../models/favorite_model.dart';
import '../../../managers/variables/values.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());
  static FavoriteCubit get(context) => BlocProvider.of(context);



  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: EndPoint.favoriteApi,
      data:{
        "nationalId": nationalId,
      }
    ).then((value) {
      favoritesModel = FavoritesModel?.fromJson(value.data);

      emit(GetFavoritesSuccessState());
    }).catchError((error){
      emit(GetFavoritesErrorState(error.toString()));
      print(error.toString());
    });
  }






  ChangeFavoritesModel? addFavoritesModel;
  void addFavorites(productId)
  {
    emit(AddFavoritesLoadingState());
    DioHelper.postData(
      url: EndPoint.favoriteApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
      },
    ).then((value) {
      addFavoritesModel = ChangeFavoritesModel?.fromJson(value?.data);
      print(value?.data);
      emit(AddFavoritesSuccessState(addFavoritesModel! ));
      getFavorites();

    }).catchError((error){
      // favorites[productId] = !favorites[productId]!;
      emit(AddFavoritesErrorState(error.toString()));
      print(error.toString());
    });
  }






  ChangeFavoritesModel? deleteFavoritesModel;
  void deleteFavorites(productId)
  {
    emit(DeleteFavoritesLoadingState());
    DioHelper.deleteData(
      url: EndPoint.favoriteApi,
      data: {
        "nationalId": nationalId,
        "productId": productId,
      },
    ).then((value) {
      deleteFavoritesModel = ChangeFavoritesModel?.fromJson(value?.data);
      print(value?.data);
      emit(DeleteFavoritesSuccessState(deleteFavoritesModel! ));
      getFavorites();

    }).catchError((error){
      emit(DeleteFavoritesErrorState(error.toString()));
      print(error.toString());
    });
  }



}