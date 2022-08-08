# Skybase Flutter

## Overview
A Flutter Base project that developed with :
- Clean Architecture
- Getx Ecosystem (State, Storage, Binding, Route)
- Dio
- Refresh Token handler


## Initial Setup

### Install Mason

    dart pub global activate mason_cli

### Create Shortcut for Mason
Open terminal and run this command in terminal
this command to set alias for mason CLI

    alias sky_create_view="cd mason && mason make sky_view -o ../lib && cd .."
    
    alias sky_create_repo="cd mason && mason make sky_repo -o ../lib && cd .."
    
    alias sky_create_api="cd mason && mason make sky_api -o ../lib && cd .."
    
    alias sky_create_feature="cd mason && mason make sky_feature -o ../lib && cd .."

### Mason CLI usage
Create full feature :

    sky_create_feature

Create View/Page :

    sky_create_view

Create Repository :

    sky_create_repo

Create Datasource (ApiService) :

    sky_create_api


## Reference
- [Clean Architecture](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [Getx Ecosystem](https://medium.com/flutter-community/the-flutter-getx-ecosystem-state-management-881c7235511d)
- [Refresh Token Handler](https://medium.com/nusanet/flutter-refresh-token-authentication-4c8a58071d75)
- [QueueInterceptor](https://github.com/flutterchina/dio/issues/1308)
- [Mason CLI] https://pub.dev/packages/mason_cli



### Created by
Varcant
( nanda.kista@gmail.com )

