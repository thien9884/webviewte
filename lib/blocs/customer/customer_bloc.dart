import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/my_system/my_system_model.dart';
import 'package:webviewtest/services/api_call.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class CustomerBloc extends BaseBloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerAddressInitial()) {
    // GET NEWS EVENT
    on<RequestGetCustomerAddress>((event, emit) {
      int? customerId = event.customerId;
      return _handleGetCustomerAddress(emit, customerId);
    });
    on<RequestPostAddAddress>((event, emit) {
      int? customerId = event.customerId;
      Addresses? addAddressModel = event.addAddressModel;
      return _handlePostAddAddress(emit, customerId, addAddressModel);
    });
    on<RequestPutAddress>((event, emit) {
      PutAddress? putAddress = event.putAddress;
      return _handlePutAddress(emit, putAddress);
    });
    on<RequestDeleteAddress>((event, emit) {
      int? customerId = event.customerId;
      int? addressId = event.addressId;
      return _handleDeleteAddress(emit, customerId, addressId);
    });
    on<RequestPutInfo>((event, emit) {
      InfoModel? infoModel = event.infoModel;
      return _handlePutInfo(emit, infoModel);
    });
    on<RequestGetInfo>((event, emit) {
      return _handleGetInfo(event, emit);
    });
    on<RequestGetState>((event, emit) {
      return _handleGetState(event, emit);
    });
    on<RequestDeleteAccount>((event, emit) {
      return _handleDeleteAccount(event, emit);
    });
    on<RequestGetRatingHistory>((event, emit) {
      int? customerId = event.customerId;
      return _handleGetRatingHistory(emit, customerId);
    });
    on<RequestGetProductRating>((event, emit) {
      int? productId = event.productId;
      return _handleGetProductRating(emit, productId);
    });
    on<RequestGetMySystem>((event, emit) {
      int? levelId = event.levelId;
      int? page = event.page;
      int? size = event.size;
      return _handleGetMySystem(emit, levelId, page, size);
    });
    on<RequestGetAvatar>((event, emit) {
      return _handleGetAvatar(
        event,
        emit,
      );
    });
    on<RequestUploadAvatar>((event, emit) {
      File? avatar = event.file;
      return _handleUploadAvatar(emit, avatar);
    });
  }

  _handleGetCustomerAddress(
      Emitter<CustomerState> emit, int? customerId) async {
    emit(const CustomerAddressLoading());
    try {
      final data = await ApiCall().requestGetCustomerAddress(customerId);
      emit(
        CustomerAddressLoaded(customerModel: data ?? CustomerModel()),
      );
    } catch (e) {
      emit(
        CustomerAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePostAddAddress(Emitter<CustomerState> emit, int? customerId,
      Addresses? addAddressModel) async {
    emit(const AddAddressLoading());
    try {
      final data =
          await ApiCall().requestPostAddAddress(customerId, addAddressModel);
      emit(
        AddAddressLoaded(addAddressModel: data ?? Addresses()),
      );
    } catch (e) {
      emit(
        AddAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePutAddress(
    Emitter<CustomerState> emit,
    PutAddress? putAddress,
  ) async {
    emit(const PutAddressLoading());
    try {
      final data = await ApiCall().requestPutAddress(putAddress);
      emit(
        PutAddressLoaded(message: data),
      );
    } catch (e) {
      emit(
        PutAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetInfo(RequestGetInfo event, Emitter<CustomerState> emit) async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;

    emit(const GetInfoLoading());
    try {
      final data = await ApiCall().requestGetInfo();
      sPref.setInfoCustomer(jsonEncode(data));

      emit(
        GetInfoLoaded(infoModel: data ?? InfoModel()),
      );
    } catch (e) {
      emit(
        GetInfoLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetRatingHistory(Emitter<CustomerState> emit, int? customerId) async {
    emit(const RatingHistoryLoading());
    try {
      final data = await ApiCall().requestGetRatingHistory(customerId);
      emit(
        RatingHistoryLoaded(
          listRatingModel: data ?? [],
        ),
      );
    } catch (e) {
      emit(
        RatingHistoryLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetProductRating(Emitter<CustomerState> emit, int? productId) async {
    emit(const ProductRatingLoading());
    try {
      final data = await ApiCall().requestGetProduct(productId);
      emit(
        ProductRatingLoaded(
          productsModel: data,
        ),
      );
    } catch (e) {
      emit(
        ProductRatingLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleDeleteAddress(
      Emitter<CustomerState> emit, int? customerId, int? addressId) async {
    emit(const DeleteAddressLoading());
    try {
      final data = await ApiCall().requestDeleteAddress(customerId, addressId);
      emit(
        DeleteAddressLoaded(
          message: data,
        ),
      );
    } catch (e) {
      emit(
        DeleteAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePutInfo(Emitter<CustomerState> emit, InfoModel? infoModel) async {
    emit(const PutInfoLoading());
    try {
      final data = await ApiCall().requestUpdateInfo(infoModel);
      emit(
        PutInfoLoaded(
          message: data,
        ),
      );
    } catch (e) {
      emit(
        PutInfoLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetState(RequestGetState event, Emitter<CustomerState> emit) async {
    emit(const GetStateLoading());
    try {
      final data = await ApiCall().requestGetState();
      emit(
        GetStateLoaded(
          stateModel: data ?? [],
        ),
      );
    } catch (e) {
      emit(
        GetStateLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetAvatar(
    RequestGetAvatar event,
    Emitter emit,
  ) async {
    emit(const GetAvatarLoading());
    try {
      final data = await ApiCall().requestGetAvatar();
      emit(
        GetAvatarLoaded(avatar: data ?? ''),
      );
    } catch (e) {
      emit(
        GetAvatarLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetMySystem(
      Emitter<CustomerState> emit, int? levelId, int? page, int? size) async {
    emit(const MySystemLoading());
    try {
      final data = await ApiCall().requestGetMySystem(levelId, page, size);
      emit(
        MySystemLoaded(
          mySystemModel: data ?? MySystemModel(),
        ),
      );
    } catch (e) {
      emit(
        MySystemLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleUploadAvatar(Emitter<CustomerState> emit, File? avatar) async {
    emit(const UploadAvatarLoading());
    try {
      final data = await ApiCall().requestChangeAvatar(avatar);
      emit(
        UploadAvatarLoaded(
          avatar: data ?? '',
        ),
      );
    } catch (e) {
      emit(
        UploadAvatarLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleDeleteAccount(
      RequestDeleteAccount event, Emitter<CustomerState> emit) async {
    emit(const DeleteAccountLoading());
    try {
      final data = await ApiCall().requestDeleteAccount();
      emit(
        DeleteAccountLoaded(
          avatar: data,
        ),
      );
    } catch (e) {
      emit(
        DeleteAccountLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
