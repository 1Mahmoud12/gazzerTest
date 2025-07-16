import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_di.dart';
import 'login_data.dart';

@GenerateMocks([LoginRepoImp])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  final loginData = LoginData();
  final repo = diTest.get<LoginRepo>();
  late LoginCubit cubit;
  group('test HomeCubit logic', () {
    setUp(() {
      cubit = LoginCubit(repo);
    });
    tearDown(() => cubit.close());

    test('test cubit initial state', () {
      expect(cubit.state, isInstanceOf<LoginInitialState>());
    });
    group('Test Login method', () {
      blocTest<LoginCubit, LoginStates>(
        'test login method with login request that completes with success',
        setUp: () {
          provideDummy<Result<String>>(const Ok("Client logged in successfully"));
          when(repo.login(loginData.validPhone, loginData.validPassword)).thenAnswer((_) async {
            return const Ok("Client logged in successfully");
          });
        },
        build: () => cubit,
        act: (bloc) => bloc.login(loginData.validPhone, loginData.validPassword),
        expect: () => [isInstanceOf<LoginLoadingState>(), isInstanceOf<LoginSuccessState>()],
        verify: (_) => verify(repo.login(loginData.validPhone, loginData.validPassword)).called(1),
      );
      blocTest<LoginCubit, LoginStates>(
        'test login method with login request that completes with error',
        setUp: () {
          provideDummy<Result<String>>(Err(BadResponse.fromJson(loginData.loginErrorJson)));
          when(repo.login(loginData.validPhone, loginData.validPassword)).thenAnswer((_) async {
            return Err(BadResponse.fromJson(loginData.loginErrorJson));
          });
        },
        build: () => cubit,
        act: (bloc) => bloc.login(loginData.validPhone, loginData.validPassword),
        expect: () => [isInstanceOf<LoginLoadingState>(), isInstanceOf<LoginErrorState>()],
        verify: (_) => verify(repo.login(loginData.validPhone, loginData.validPassword)).called(1),
      );
    });
  });
  blocTest<LoginCubit, LoginStates>(
    'Test Cubit emit guard - should not throw exception when emitting state after close',
    setUp: () {
      cubit = LoginCubit(repo);
      cubit.close();
    },
    build: () => cubit,
    act: (bloc) {
      // This should not throw an exception even though the cubit is closed
      expect(() => bloc.emit(LoginLoadingState()), returnsNormally);
    },
    expect: () => [],
    verify: (bloc) {
      // Verify that the cubit is indeed closed
      expect(bloc.isClosed, isTrue);
    },
  );
}
