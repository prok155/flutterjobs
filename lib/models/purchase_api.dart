import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseApi {
  PurchaseApi._internal();
  static final PurchaseApi _instance = PurchaseApi._internal();
  static PurchaseApi get instance => _instance;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<dynamic> _streamSubscription;
  List<ProductDetails> _products = [];
  static const _variant = {
    'premiumAndroid',
    'premiumIOS',
  };

  Future<void> initInAppPurchase() async {
    Stream purchaseUpdated = _inAppPurchase.purchaseStream;
    _streamSubscription = purchaseUpdated.listen((purchaseList) {
      _listenToPurchase(purchaseList);
    }, onDone: () {
      _streamSubscription.cancel();
    }, onError: (error) {
      print('Error : ${error.toString()}');
    });
    initStore();
    /*if (Platform.isAndroid) {
      configuration = PurchasesConfiguration('<public_google_api_key>');
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration('<public_apple_api_key>');
    }
    await Purchases.configure(configuration);*/
  }

  void _listenToPurchase(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetail) async {
        if (purchaseDetail.status == PurchaseStatus.pending) {
          print('Pending');
        } else {
          if (purchaseDetail.status == PurchaseStatus.error) {
            print('Error');
          } else if (purchaseDetail.status == PurchaseStatus.purchased) {
            print('Purchased');
          } else if (purchaseDetail.status == PurchaseStatus.canceled) {
            print('Canceled');
          } else if (purchaseDetail.status == PurchaseStatus.restored) {
            print('Restored');
          }
          if (purchaseDetail.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetail);
          }
        }
      },
    );
  }

  void initStore() async {
    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_variant);

    if (productDetailsResponse.error == null) {
      _products = productDetailsResponse.productDetails;
    }
  }

  void buy() {
    final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
    _inAppPurchase.buyConsumable(purchaseParam: param);
  }
}
