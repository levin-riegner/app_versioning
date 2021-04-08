# lr_app_versioning

L+R app versioning package

The intent behind this plugin is to provide an easy way to force app updates for users below a certain version specified on a backend service.
In the future it could also support optional updates whenever a new version is available on their respective store.

## Getting Started

Run `flutter pub upgrade && flutter pub get` to get the project dependencies.

Run the `Example` project to test the app.

## Backend Services

This plugin currently supports 2 different backends

1. **API**: An arbitrary URL endpoint that returns the minimum versions JSON.
2. **Firebase Remote Config**: Key/value pairs with the minimum versions specified on Firebase.
    > This requires the project to include and set up Firebase.

