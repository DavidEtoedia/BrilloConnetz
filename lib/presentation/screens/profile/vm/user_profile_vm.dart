import 'package:brillo_connetz/data/repository/auth_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileProvider = FutureProvider((ref) async {
  return ref.watch(authImplProvider).currentUser();
});
