// extension SnackbarHelpers on BuildContext {
//   void showSnackBar(String message, [bool isError = false]) {
//     ScaffoldMessenger.of(this).clearSnackBars();
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               isError
//                   ? Icons.error
//                   : Icons.check,
//             ),
//             10.sp.wSpace,
//             Expanded(
//               child: TextView(
//                 message,
//                 style: AppStyles.bodyLarge(
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: isError
//             ? AppColors.colorGoogleRed500
//             : AppColors.colorGoogleGreen500,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.sp),
//         ),
//         duration: const Duration(seconds: 2),
//         clipBehavior: Clip.none,
//         elevation: 0,
//       ),
//     );
//   }

//   void showActionSnackBar(String message,
//       {bool isError = false, String? actionLabel, Function()? onAction}) {
//     ScaffoldMessenger.of(this).clearSnackBars();
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               isError
//                   ? UIcons.regularStraight.exclamation
//                   : UIcons.regularStraight.check,
//             ),
//             10.sp.wSpace,
//             Expanded(
//               child: TextView(
//                 message,
//                 style: AppStyles.labelMedium(
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: isError
//             ? AppColors.colorGoogleRed500
//             : AppColors.colorGoogleGreen500,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.sp),
//         ),
//         clipBehavior: Clip.none,
//         elevation: 0,
//         duration: const Duration(seconds: 15),
//         action: (actionLabel != null && onAction != null)
//             ? SnackBarAction(
//                 label: actionLabel,
//                 onPressed: () {
//                   ScaffoldMessenger.of(Constants.globalKey.currentContext!)
//                       .hideCurrentSnackBar();
//                   onAction();
//                 },
//                 textColor: AppColors.whiteColor,
//               )
//             : null,
//       ),
//     );
//   }
// }
