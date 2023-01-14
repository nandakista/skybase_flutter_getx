# Skybase Flutter

## Overview
A Flutter Base project that developed with :
- Clean Architecture
- Getx Ecosystem
- Dio
- Hive


## Initial Setup

Please follow this instruction to setup codebase.

### Download Manager
if you use download manager you need to setup flutter_downloader from this
[flutter_downloader](https://pub.dev/packages/flutter_downloader)


### Install Mason
Run this command if you haven't install mason

    dart pub global activate mason_cli

### Get Sky Bricks Config
Get sky bricks from mason cofig by this command

    cd mason && mason get

### Set Sky Brick Globally
Open terminal and run this command in terminal to set alias for mason CLI

    mason add -g sky_view --path mason/bricks/sky_view
    
    mason add -g sky_repo --path mason/bricks/sky_repo
    
    mason add -g sky_api --path mason/bricks/sky_api

    mason add -g sky_dao --path mason/bricks/sky_dao
    
    mason add -g sky_feature --path mason/bricks/sky_feature

### Mason CLI usage
Create full feature :

    mason make sky_feature

Create View/Page :

    mason make sky_view

Create Repository :

    mason make sky_repo

Create Datasource (ApiService) :

    mason make sky_api

Create Dao :

    mason make sky_dao

Create by config :

    mason make <brick> -c <config-path>

## Reference
- [Clean Architecture](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [Getx Ecosystem](https://medium.com/flutter-community/the-flutter-getx-ecosystem-state-management-881c7235511d)
- [Refresh Token Handler](https://medium.com/nusanet/flutter-refresh-token-authentication-4c8a58071d75)
- [QueueInterceptor](https://github.com/flutterchina/dio/issues/1308)
- [Mason CLI](https://pub.dev/packages/mason_cli)



### Created by
Varcant
( nanda.kista@gmail.com )

