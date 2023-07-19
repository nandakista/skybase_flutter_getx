# Skybase Flutter

## Overview
A Flutter Base project that developed with :
- Clean Architecture
- Getx Ecosystem
- Dio
- Hive

## Skybase Documentation
Read [this documentation](https://docs.google.com/document/d/1ZwO60uk2SnqVBfL-L7tmIu6ykHCB8MCHP9VxE-ijXYM/edit?usp=share_link) to understand architecture, state, pattern, and style guide of the skybase.

## Mason CLI Supported
This codebase supports the use of the Mason CLI library. Follow [this instruction](https://docs.google.com/document/d/1JfoTDzJ8FqCatVjTdzOn_9rDcIJBqadaSlvUZn53UCc/edit?usp=share_link) if you want to use or setup Mason CLI.

## Build

Open terminal in root project and input command below.

Note: `<env>` is `staging` | `production`

### Android

    // Choose one

    // build apk
    sh build_apk.sh <env> 1.0.0-beta.1 1

    // build apk menggunakan version dari pubspec.yaml
    sh build_pub_apk.sh <env>

### iOS

    // Choose one

    // generate archive
    sh build_ios.sh <env> 1.0.0-beta.1 1

    // generate ipa adhoc
    sh build_ipa_adhoc.sh <env> 1.0.0-beta.1 1

    // build archive menggunakan version dari pubspec.yaml
    sh build_pub_ios.sh <env>

    // build ipa menggunakan version dari pubspec.yaml
    sh build_pub_ipa_adhoc.sh <env>

## Download Manager
If you use download manager you need to setup flutter_downloader from this
[flutter_downloader](https://pub.dev/packages/flutter_downloader)

## Reference
- [Skybase Documentation](https://docs.google.com/document/d/1ZwO60uk2SnqVBfL-L7tmIu6ykHCB8MCHP9VxE-ijXYM/edit?usp=share_link)
- [Clean Architecture](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [Getx Ecosystem](https://medium.com/flutter-community/the-flutter-getx-ecosystem-state-management-881c7235511d)
- [Refresh Token Handler](https://medium.com/nusanet/flutter-refresh-token-authentication-4c8a58071d75)
- [QueueInterceptor](https://github.com/flutterchina/dio/issues/1308)
- [Mason CLI](https://pub.dev/packages/mason_cli)



### Created by
Varcant
( nanda.kista@gmail.com )

Copyright ©2021 Skybase. All rights reserved.

