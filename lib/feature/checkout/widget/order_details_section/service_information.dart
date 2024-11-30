import 'package:demandium/feature/checkout/widget/order_details_section/select_address_dialog.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/core_export.dart';

class AddressInformation extends StatelessWidget {
  final bool isFromCreatePostPage;
  const AddressInformation({
    super.key,
    this.isFromCreatePostPage = false
  }) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      initState: (state) async {
        await Get.find<LocationController>().getAddressList();
        },
      builder: (locationController) {
        AddressModel? addressModel;

        if(locationController.selectedAddress !=null && (locationController.selectedAddress?.zoneId == locationController.getUserAddress()?.zoneId)){
          addressModel = locationController.selectedAddress ;
        }else{
          addressModel = locationController.getUserAddress();
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          isFromCreatePostPage == true ? const SizedBox() : Text('service_address'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Container( width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSeven), color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3), width: 0.5),
            ),
            child: Center( child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, crossAxisAlignment:CrossAxisAlignment.start, children: [
              Expanded( flex: 7,
                child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                  addressModel!.contactPersonName != null && addressModel.contactPersonName != "" && !addressModel.contactPersonName.toString().contains('null') ?
                  Padding( padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall, bottom: 8),
                    child: Text( addressModel.contactPersonName.toString(),
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                  ) : const SizedBox(),

                  addressModel.contactPersonNumber != null && addressModel.contactPersonNumber != "" && !addressModel.contactPersonNumber.toString().contains('null') ?
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                    child: Text(
                      addressModel.contactPersonNumber??"",
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                    ),
                  ) : const SizedBox(),

                  addressModel.address != null ? const SizedBox(height: Dimensions.paddingSizeExtraSmall,) : const SizedBox(),

                  Row( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.location_on_sharp, size: 15, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 3),
                    Expanded( child: Text( addressModel.address!, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    )),
                  ]),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                  addressModel.contactPersonName != null && addressModel.contactPersonName != "" && addressModel.contactPersonNumber != null ?
                  Padding( padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                    child: Text(addressModel.country ?? "",
                      style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: Dimensions.fontSizeExtraSmall
                      ),
                    ),
                  ) :
                  Padding( padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Text("* ${"please_input_contact_person_name_and_phone_number".tr}",style: robotoMedium.copyWith(
                      color: Theme.of(context).colorScheme.error.withOpacity(.8),
                      fontSize: Dimensions.fontSizeExtraSmall,
                    )),
                  )

                ]),
              ),
              Center(child: InkWell( onTap: () {
                showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
                transitionBuilder: (context, a1, a2, widget) {
                  return Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: Center( child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            color: Theme.of(context).cardColor
                        ),
                        margin: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeLarge, vertical: 100),
                        child: Stack(
                          alignment: Alignment.topRight,
                          clipBehavior: Clip.none,
                          children: [
                            SelectAddressDialog(addressList: locationController.addressList??[], selectedAddressId: addressModel?.id,),
                            Positioned(top: -20,right: -20,child: Icon(Icons.cancel,color: Theme.of(context).cardColor,))
                          ],
                        ),
                      )),
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                context: Get.context!,
                pageBuilder: (context, animation1, animation2){
                  return Container();
                },
              );
                }, child: Image.asset(Images.editButton,height: 20,width: 20,)),
              ),
            ]),
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
        ]);
      },
    );
  }
}