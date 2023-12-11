abstract class CartStates {}

class CartInitState extends CartStates {}

class AddToCartSuccessState extends CartStates {}

class AddToCartErrorState extends CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartSuccessState extends CartStates {}

class GetCartErrorState extends CartStates {}

class DeleteCartSuccessState extends CartStates {}

class DeleteCartErrorState extends CartStates {}

class UpdateCartSuccessState extends CartStates {}

class UpdateCartErrorState extends CartStates {}


class RemoveFromCartState extends CartStates {}

class AddToCartState extends CartStates {}
