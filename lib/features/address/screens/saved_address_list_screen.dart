import 'package:flutter/material.dart';
import 'package:da3em/features/address/controllers/address_controller.dart';
import 'package:da3em/features/address/widgets/address_shimmer.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/features/product_details/widgets/form_checkout.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_app_bar_widget.dart';
import 'package:da3em/common/basewidget/no_internet_screen_widget.dart';
import 'package:da3em/features/address/widgets/address_type_widget.dart';
import 'package:provider/provider.dart';

import 'add_new_address_screen.dart';

class SavedAddressListScreen extends StatefulWidget {
  final bool fromGuest;
  const SavedAddressListScreen({super.key, this.fromGuest = false});

  @override
  State<SavedAddressListScreen> createState() => _SavedAddressListScreenState();
}

class _SavedAddressListScreenState extends State<SavedAddressListScreen> {
  @override
  void initState() {
    Provider.of<AddressController>(context, listen: false).getAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const FormCheckout();
              });
           Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AddNewAddressScreen(isBilling: false)));
        },
      ),
      appBar: CustomAppBar(
          title: widget.fromGuest
              ? getTranslated('ADDRESS_LIST', context)
              : getTranslated('SHIPPING_ADDRESS_LIST', context)),
      body: SafeArea(child: Consumer<AddressController>(
        builder: (context, locationProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                locationProvider.addressList != null
                    ? locationProvider.addressList!.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: locationProvider.addressList?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Provider.of<CheckoutController>(context,
                                            listen: false)
                                        .setAddressIndex(index);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeDefault),
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              top: Dimensions.paddingSizeSmall),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: ColorResources.getIconBg(
                                                  context),
                                              border: index ==
                                                      Provider.of<CheckoutController>(context)
                                                          .addressIndex
                                                  ? Border.all(
                                                      width: 2,
                                                      color: Theme.of(context)
                                                          .primaryColor)
                                                  : null),
                                          child: AddressTypeWidget(
                                              address: locationProvider
                                                  .addressList?[index]))));
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeLarge),
                                    child: const NoInternetOrDataScreenWidget(
                                        isNoInternet: false,
                                        message: 'no_address_found',
                                        icon: Images.noAddress))))
                    : const AddressShimmerWidget(),
              ],
            ),
          );
        },
      )),
    );
  }
}
