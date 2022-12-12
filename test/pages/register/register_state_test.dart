import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/register/register_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given initial state, then validate state', () async {
    RegisterState state = RegisterState.initialState();

    expect(state.error, null);
    expect(state.isRegistered, false);
    expect(state.isRegistering, false);
  });
  test('given registering, then validate state', () async {
    RegisterState state = RegisterState.registering();

    expect(state.error, null);
    expect(state.isRegistered, false);
    expect(state.isRegistering, true);
  });
  test('given registered, then validate state', () async {
    RegisterState state = RegisterState.registered();

    expect(state.error, null);
    expect(state.isRegistered, true);
    expect(state.isRegistering, false);
  });
  test('given error, then validate state', () async {
    ErrorModel error = ErrorModel(code: "anyCode", message: "anyMessage");
    RegisterState state = RegisterState.err(error);

    expect(state.error, error);
    expect(state.isRegistered, false);
    expect(state.isRegistering, false);
  });
}
