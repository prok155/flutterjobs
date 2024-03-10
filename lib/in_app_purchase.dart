import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseWidget extends StatefulWidget {
  const InAppPurchaseWidget({super.key});

  @override
  State<InAppPurchaseWidget> createState() => _InAppPurchaseWidgetState();
}

class _InAppPurchaseWidgetState extends State<InAppPurchaseWidget> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<dynamic> _streamSubscription;
  List<ProductDetails> _products = [];
  static const _variant = {
    'premiumAndroid',
    'premiumIOS',
  };
  @override
  void initState() {
    super.initState();
    initInAppPurchase();
  }

  Future<void> initInAppPurchase() async {
    Stream purchaseUpdated = _inAppPurchase.purchaseStream;
    _streamSubscription = purchaseUpdated.listen((purchaseList) {
      _listenToPurchase(purchaseList);
    }, onDone: () {
      _streamSubscription.cancel();
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error : ${error.toString()}'),
        ),
      );
      print('Error : ${error.toString()}');
    });
    initStore();
  }

  void _listenToPurchase(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetail) async {
        if (purchaseDetail.status == PurchaseStatus.pending) {
          print('Pending');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pending'),
            ),
          );
        } else {
          if (purchaseDetail.status == PurchaseStatus.error) {
            print('Error');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error'),
              ),
            );
          } else if (purchaseDetail.status == PurchaseStatus.purchased) {
            print('Purchased');

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Purchased'),
              ),
            );
          } else if (purchaseDetail.status == PurchaseStatus.canceled) {
            print('Canceled');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Canceled'),
              ),
            );
          } else if (purchaseDetail.status == PurchaseStatus.restored) {
            print('Restored');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Restored'),
              ),
            );
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
      setState(() {
        _products = productDetailsResponse.productDetails;
      });
    }
  }

  void buy() async {
    final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
    await _inAppPurchase.buyNonConsumable(purchaseParam: param);
  }

  void restore() async {
    final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
    await _inAppPurchase.restorePurchases();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            buy();
          },
          child: const Text('purchase product'),
        ),
        ElevatedButton(
          onPressed: () {
            restore();
          },
          child: const Text('Restore Product'),
        ),
      ],
    );
  }
}
