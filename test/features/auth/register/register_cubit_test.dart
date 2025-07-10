import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_di.dart';
import 'register_data.dart';

@GenerateMocks([RegisterRepoImp])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  final registerData = RegisterData();
  final repo = diTest.get<RegisterRepo>();
  late RegisterCubit cubit;
  group('test HomeCubit logic', () {
    setUp(() {
      cubit = RegisterCubit(repo);
    });
    tearDown(() => cubit.close());

    test('test cubit initial state', () {
      expect(cubit.state, isInstanceOf<RegisterInitial>());
    });
    group('Test Register method', () {
      blocTest<RegisterCubit, RegisterStates>(
        'test register method with register request that completes with success',
        setUp: () {
          provideDummy<Result<AuthResponse>>(Ok(AuthResponse.fromJson(registerData.registerSuccessJson)));
          when(repo.register(registerData.registerReq)).thenAnswer((_) async {
            return Ok<AuthResponse>(AuthResponse.fromJson(registerData.registerSuccessJson));
          });
        },
        build: () => cubit,
        act: (bloc) => bloc.register(registerData.registerReq),
        expect: () => [isInstanceOf<RegisterLoading>(), isInstanceOf<RegisterSuccess>()],
        verify: (_) => verify(repo.register(registerData.registerReq)).called(1),
      );
      blocTest<RegisterCubit, RegisterStates>(
        'test register method with register request that completes with error',
        setUp: () {
          provideDummy<Result<AuthResponse>>(Err(ApiError.fromJson(registerData.registerPhoneExistsErrorJson)));
          when(repo.register(registerData.registerReq)).thenAnswer((_) async {
            return Err<AuthResponse>(ApiError.fromJson(registerData.registerPhoneExistsErrorJson));
          });
        },
        build: () => cubit,
        act: (bloc) => bloc.register(registerData.registerReq),
        expect: () => [isInstanceOf<RegisterLoading>(), isInstanceOf<RegisterError>()],
        verify: (_) => verify(repo.register(registerData.registerReq)).called(1),
      );
    });
  });
  blocTest<RegisterCubit, RegisterStates>(
    'Test Cubit emit guard - should not throw exception when emitting state after close',
    setUp: () {
      cubit = RegisterCubit(repo);
      cubit.close();
    },
    build: () => cubit,
    act: (bloc) {
      // This should not throw an exception even though the cubit is closed
      expect(() => bloc.emit(RegisterLoading()), returnsNormally);
    },
    expect: () => [],
    verify: (bloc) {
      // Verify that the cubit is indeed closed
      expect(bloc.isClosed, isTrue);
    },
  );
}
