# App Links Setup Guide

This guide explains how to set up App Links (Universal Links for iOS and App Links for Android) for
the Gazzer app.

## Domain Configuration

The app is configured to handle deep links from: `https://tkgazzer.com`

## iOS Setup (Universal Links)

### 1. Apple App Site Association File

Create a file at: `https://tkgazzer.com/.well-known/apple-app-site-association`

**Important:** This file must be:

- Served over HTTPS
- Have `Content-Type: application/json` header
- Not have a `.json` extension
- Be accessible without authentication

Example content:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.example.gazzer",
        "paths": [
          "*"
        ]
      }
    ]
  }
}
```

Replace `TEAM_ID` with your Apple Developer Team ID and `com.example.gazzer` with your actual bundle
identifier.

### 2. Info.plist Configuration

The `Info.plist` file has been configured with:

- Associated domains: `applinks:tkgazzer.com`
- Custom URL scheme: `gazzar://`

## Android Setup (App Links)

### 1. Digital Asset Links File

Create a file at: `https://tkgazzer.com/.well-known/assetlinks.json`

**Important:** This file must be:

- Served over HTTPS
- Have `Content-Type: application/json` header
- Be accessible without authentication

Example content:

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example.gazzer",
    "sha256_cert_fingerprints": [
      "YOUR_APP_SHA256_FINGERPRINT"
    ]
  }
}]
```

Replace:

- `com.example.gazzer` with your actual package name
- `YOUR_APP_SHA256_FINGERPRINT` with your app's SHA-256 certificate fingerprint

### 2. Get SHA-256 Fingerprint

For debug builds:

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

For release builds:

```bash
keytool -list -v -keystore your-release-key.keystore -alias your-key-alias
```

### 3. AndroidManifest.xml Configuration

The `AndroidManifest.xml` has been configured with:

- Intent filter for `https://tkgazzer.com`
- Intent filter for custom scheme `gazzar://`
- `android:autoVerify="true"` for App Links verification

## Deep Link Patterns Supported

The app handles the following deep link patterns:

1. **Invite Links**: `https://tkgazzer.com/invite?ref=REFERRAL_CODE`
    - Opens register screen with pre-filled referral code

2. **Product Links**: `https://tkgazzer.com/product/PRODUCT_ID` or
   `https://tkgazzer.com/pr/PRODUCT_ID`
    - Opens product details screen

3. **Category Links**: `https://tkgazzer.com/category/CATEGORY_ID` or
   `https://tkgazzer.com/ca/CATEGORY_ID`
    - Opens category screen

4. **Store Links**: `https://tkgazzer.com/store/STORE_ID`
    - Opens store details screen

5. **Custom Scheme**: `gazzar://invite?ref=REFERRAL_CODE`
    - Same as invite links but using custom scheme

## Testing

### iOS Testing

1. Test Universal Links: Open `https://tkgazzer.com/invite?ref=TEST123` in Safari
2. Test Custom Scheme: Open `gazzar://invite?ref=TEST123` in Safari

### Android Testing

1. Test App Links: Use ADB command:
   ```bash
   adb shell am start -a android.intent.action.VIEW -d "https://tkgazzer.com/invite?ref=TEST123"
   ```
2. Test Custom Scheme:
   ```bash
   adb shell am start -a android.intent.action.VIEW -d "gazzar://invite?ref=TEST123"
   ```

## Verification

### iOS

- Verify the `.well-known/apple-app-site-association` file is accessible
- Check that the file is served with correct content type
- Test in Safari to ensure links open in the app

### Android

- Verify the `.well-known/assetlinks.json` file is accessible
- Use Google's App Links
  Tester: https://digitalassetlinks.googleapis.com/v1/statements:list?source.web.site=https://tkgazzer.com&relation=delegate_permission/common.handle_all_urls
- Check Android logcat for verification status

## Notes

- The app listens for deep links both when the app is open and when it's launched from a terminated
  state
- Deep link handling is implemented in `lib/core/data/services/deep_link_service.dart`
- The service is initialized in `lib/gazzer_app.dart`


