// lib/features/addresses/providers/address_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/address.dart';
import '../repositories/address_repository.dart';

final addressRepositoryProvider = Provider<AddressRepository>((_) => AddressRepository());

class AddressNotifier extends StateNotifier<AsyncValue<List<Address>>> {
  final AddressRepository _repo;

  AddressNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repo.getAddresses());
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _repo.createAddress(data);
    await load();
  }

  Future<void> update(int id, Map<String, dynamic> data) async {
    await _repo.updateAddress(id, data);
    await load();
  }

  Future<void> delete(int id) async {
    await _repo.deleteAddress(id);
    state = AsyncValue.data(state.valueOrNull?.where((a) => a.id != id).toList() ?? []);
  }

  Future<void> setDefault(int id) async {
    await _repo.setDefaultAddress(id);
    await load();
  }
}

final addressProvider =
    StateNotifierProvider<AddressNotifier, AsyncValue<List<Address>>>((ref) {
  return AddressNotifier(ref.read(addressRepositoryProvider));
});
