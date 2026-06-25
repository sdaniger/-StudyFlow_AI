import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import '../../../../core/security/secure_config.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: [drive.DriveApi.driveAppdataScope],
    clientId: SecureConfig.googleClientId,
  );
});

final googleDriveAuthProvider = StateNotifierProvider<GoogleDriveAuthNotifier, AsyncValue<GoogleSignInAccount?>>((ref) {
  final signIn = ref.watch(googleSignInProvider);
  return GoogleDriveAuthNotifier(signIn);
});

class GoogleDriveAuthNotifier extends StateNotifier<AsyncValue<GoogleSignInAccount?>> {
  final GoogleSignIn _signIn;

  GoogleDriveAuthNotifier(this._signIn) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final account = await _signIn.signInSilently();
      state = AsyncValue.data(account);
    } catch (_) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signIn() async {
    try {
      state = const AsyncValue.loading();
      final account = await _signIn.signIn();
      state = AsyncValue.data(account);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    await _signIn.signOut();
    state = const AsyncValue.data(null);
  }
}
