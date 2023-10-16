
import 'package:audio_book/modules/auth/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_exception.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthState()){

    on<SignUpWithEmailPasswordEvent>((event, emit) => _signUpWithEmailPassword(email: event.email, password: event.password, emit: emit));

    on<SignInWithEmailPasswordEvent>((event, emit) => _signInWithEmailPassword(email: event.email, password: event.password, emit: emit));

    on<CheckVerificationEmailEvent>((event, emit) => _checkVerificationEmail(emit: emit));

    on<SignInWithGoogle>((event, emit) => _signInWithGoogle(emit: emit));
    
  }
  
  void _signUpWithEmailPassword({required String email,required String password, required Emitter<AuthState> emit}) async{
    emit(SignUpState(isLoading: true));
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      auth.currentUser!.sendEmailVerification();
      emit(SignUpState(isSignUpSucces: true));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
          emit(SignUpState(error: EmailAlreadyInUse()));
        }
    }
    catch (e) {
      emit(SignUpState(error: e));
    }
  }

  void _signInWithEmailPassword({required String email,required String password, required Emitter<AuthState> emit}) async {
    emit(SignInState(isLoading: true));
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        if(auth.currentUser!.emailVerified){
          emit(SignInState(isSignInSucces: true));
        }else{
          emit(SignInState(isVerificationEmail: false));
          auth.currentUser!.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        if(e.code == "INVALID_LOGIN_CREDENTIALS"){
          emit(SignInState(error: InvalidLoginCredeniala()));
        }
        if (e.code == 'user-not-found') {
          emit(SignInState(error: UserNotFound()));
        } 
        if (e.code == 'wrong-password') {
          emit(SignInState(error: WrongPassword()));
        }
      }
      catch (e) {
        emit(SignInState(error: e));
      }
  }

  void _checkVerificationEmail({required Emitter<AuthState> emit}){
    if(auth.currentUser != null){
      auth.currentUser!.reload();
      if(auth.currentUser!.emailVerified){
        emit(SignInState(isVerificationEmail: true));
      }else{
        emit(SignInState(isVerificationEmail: false));
      }
    }
  }

  void _signInWithGoogle({required Emitter<AuthState> emit}) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    emit(SignInState(isLoading: true));
    await auth.signInWithCredential(credential);
    emit(SignInState(isSignInSucces: true));
  }
}

class AuthState{}

class SignUpState extends AuthState{
  bool? isLoading;
  Object? error;
  bool? isSignUpSucces;

  SignUpState({this.error, this.isLoading, this.isSignUpSucces});
}

class SignInState extends AuthState{
  bool? isLoading;
  Object? error;
  bool? isSignInSucces;
  bool? isVerificationEmail;

  SignInState({this.error, this.isLoading, this.isSignInSucces, this.isVerificationEmail});
}