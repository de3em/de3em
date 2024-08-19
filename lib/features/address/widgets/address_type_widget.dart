import 'package:flutter/material.dart';
import 'package:da3em/features/address/domain/models/address_model.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:iconsax/iconsax.dart';

class AddressTypeWidget extends StatelessWidget {
  final AddressModel? address;
  const AddressTypeWidget({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Iconsax.location),
      title: Text(address?.address ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
    );
  }
}
