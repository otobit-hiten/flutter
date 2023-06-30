import 'package:bloc/bloc.dart';
import 'package:flutter_login/Model/LoginModel.dart';
import 'package:flutter_login/Repository/repository.dart';
import 'package:meta/meta.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  late LoginModel loginModel;
  final LoginRepo loginRepo;

  BlocBloc(this.loginRepo) : super(BlocInitial()) {
    on<BlocEvent>((event, emit) async {
     if(event is LoginFetchEvent){
       emit(LoginLoading());
       loginModel = await loginRepo.loginCall(event.phoneNumber, event.pin);
       if(loginModel.success == true){
         emit(LoginSuccessState(loginModel));
       }else{
         emit(LoginErrorState());
       }
     }
    });
  }
}
