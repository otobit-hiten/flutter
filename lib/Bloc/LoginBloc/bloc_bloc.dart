import 'package:bloc/bloc.dart';
import 'package:flutter_login/Model/LoginModel.dart';
import 'package:flutter_login/Model/ModelUpdate.dart';
import 'package:flutter_login/Repository/repository.dart';
import 'package:meta/meta.dart';
import '../../Model/ModelGetUserById.dart';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  late LoginModel loginModel;
  late ModelUpdate modelUpdate;
  late ModelGetUserById modelGetUserById;

  BlocBloc() : super(BlocInitial()) {
    final LoginRepo loginRepo = LoginRepo();
    on<BlocEvent>((event, emit) async {
     if(event is LoginFetchEvent){
       emit(LoginLoading());
       await Future.delayed(Duration(seconds: 1));
       loginModel = await loginRepo.loginCall(event.phoneNumber, event.pin);
       if(loginModel.success == true){
         emit(LoginSuccessState(loginModel));
       }else{
         emit(LoginErrorState());
       }
     }

     if(event is UpdateEvent){
       emit(UpdateLoading());
       await Future.delayed(Duration(seconds: 1));
       modelUpdate = await loginRepo.update(event.phoneNumber, event.gender, event.email, event.id, event.roleId);
       if(modelUpdate.id != null){
         emit(UpdateSuccess(modelUpdate));
       }else{
         emit(UpdateError());
       }
     }

     if(event is GetUserById){
       emit(GetUserLoading());
       await Future.delayed(Duration(seconds: 2));
       modelGetUserById = await loginRepo.getUserById(event.id);
       if(modelGetUserById.data?.id != null){
         emit(GetUserBySuccess(modelGetUserById));
       }else{
         emit(GetUserByError());
       }
     }
    });
  }
}
