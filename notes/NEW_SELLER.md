# New Seller

## Apple

- Create Apple Pay Merchant ID and Certificate <https://developer.squareup.com/apps/>
- Upload APNs key to Firebase
- Add app ID
- Add bundle identifier to app audience on backend
- Add Apple Pay merchant ID to `moa_options.dart`

## Google

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
11. Fill out forms, ship it!!!!!!!!!!!!!

```json
{
    "client_id": "",
    "client_type": 1,
    "android_info": {
    "package_name": "com.myorderapp.",
    "certificate_hash": ""
}
```

## Screenshots

- Menu
- Item detail
- Review order
- Checkout

### Android

- Small: 720x1280
- Medium: 1440x2560
- Large: 2560x1440

### iOS

- iPhone 8 Plus
- iPhone 14 Plus
- iPad Pro
