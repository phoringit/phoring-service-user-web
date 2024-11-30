
import 'package:get/get.dart';
import 'package:demandium/utils/core_export.dart';

void customCouponSnackBar(String? title, { String? subtitle,bool isError = true, double margin = Dimensions.paddingSizeSmall,int duration =2, Color? backgroundColor, Widget? customWidget, double borderRadius = Dimensions.radiusSmall}) {
  if(title != null && title.isNotEmpty) {
    final width = MediaQuery.of(Get.context!).size.width;

    Get.closeAllSnackbars();
    Get.snackbar( title.tr,
      "",
      messageText: Text(
        subtitle?.tr ?? "",
        style: robotoRegular.copyWith(
            color: Colors.white.withOpacity(0.7)
        ),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey.shade900,
      borderRadius: Dimensions.paddingSizeSmall,

      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge,
          vertical: Dimensions.paddingSizeLarge
      ),
      icon: Image.asset(
          isError ? Images.couponWarning : Images.correctIcon,
          width: Dimensions.paddingSizeLarge * 2,
          height: Dimensions.paddingSizeLarge * 2
      ),
      shouldIconPulse: false,
      leftBarIndicatorColor: isError ? Colors.red : Colors.green,
      maxWidth: Dimensions.webMaxWidth,
      snackStyle: SnackStyle.FLOATING,
      margin: ResponsiveHelper.isDesktop(Get.context!) ? EdgeInsets.only(right: width * 0.7, bottom: Dimensions.paddingSizeExtraSmall,
          left: (width - Dimensions.webMaxWidth) / 2) : const EdgeInsets.symmetric( horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
    );
  }
}