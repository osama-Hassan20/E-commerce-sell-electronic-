import '../../../../models/change_favorite_model.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates{}

//GetFavorites
class GetFavoritesLoadingState extends FavoriteStates{}

class GetFavoritesSuccessState extends FavoriteStates{}

class GetFavoritesErrorState extends FavoriteStates{
  late final String error;
  GetFavoritesErrorState(this.error);
}


//DeleteFavorites
class DeleteFavoritesLoadingState extends FavoriteStates{}

class DeleteFavoritesSuccessState extends FavoriteStates{
  final ChangeFavoritesModel model;
  DeleteFavoritesSuccessState(this.model);
}

class DeleteFavoritesErrorState extends FavoriteStates{
  late final String error;
  DeleteFavoritesErrorState(this.error);
}


//AddFavorites
class AddFavoritesLoadingState extends FavoriteStates{}

class AddFavoritesSuccessState extends FavoriteStates{
  final ChangeFavoritesModel model;
  AddFavoritesSuccessState(this.model);
}

class AddFavoritesErrorState extends FavoriteStates{
  late final String error;
  AddFavoritesErrorState(this.error);
}
