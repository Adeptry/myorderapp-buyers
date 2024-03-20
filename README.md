# MyOrderApp for Buyers

> Transform your Square POS setup into a powerful mobile ordering platform with MyOrderApp. Just use Square the way you already do, and trust us to provide an exceptional mobile ordering experience for your customers. The platform features immediate synchronization with your Square Catalog and Locations, ensuring your app is always up-to-date. Effortlessly manage and rearrange your catalog’s categories, items, and variations whenever you wish.

This is the front-end customers use to make purchases.

## Quick start

1. Run [MyOrderApp backend](https://github.com/Adeptry/myorderapp-backend)
2. `flutter pub install`
3. `flutter run -d chrome --web-port 5000`
4. Go to the ID specified in the `app-config`

## Deploying

### Web

This repo is configured for deployment on Vercel

### iOS

- Create Apple Pay Merchant ID and Certificate <https://developer.squareup.com/apps/>
- Upload APNs key to Firebase
- Add app ID
- Add bundle identifier to app audience on backend
- Add Apple Pay merchant ID to `moa_options.dart`
- `flutter build ipa`

### Android

1. Pull info from DB and update `moa_options.dart`
2. Download icon, create banner, format in `assets`, &
   `flutter pub run flutter_launcher_icons` (1024x500, 500x500)
3. Create splash & `flutter pub run flutter_native_splash:create`
4. Rename in Android Manifest & Info.plist, replace `dev.myorderapp.demo`,
   `MyOrderApp Demo`
5. Create screenshots
6. Change `dev.myorderapp.demo` to `com.myorderapp.merchantname`
7. Create Firebase project & `flutterfire configure`
8. Create OAuth client ID credenentials in Google Cloud Console
9. Create Play Console app, get SHA-1 hash, setup google-services.json
10. `flutter build appbundle`
