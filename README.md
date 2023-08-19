# QNPP IOS Mobile App Mwani

[![CI Status](https://img.shields.io/travis/medhatali/IBMCoreBankingFramework.svg?style=flat)](https://travis-ci.org/medhatali/IBMCoreBankingFramework)
[![Version](https://img.shields.io/cocoapods/v/IBMCoreBankingFramework.svg?style=flat)](https://cocoapods.org/pods/IBMCoreBankingFramework)
[![License](https://img.shields.io/cocoapods/l/IBMCoreBankingFramework.svg?style=flat)](https://cocoapods.org/pods/IBMCoreBankingFramework)
[![Platform](https://img.shields.io/cocoapods/p/IBMCoreBankingFramework.svg?style=flat)](https://cocoapods.org/pods/IBMCoreBankingFramework)

# Table of contents
- [Overview](#overview)
- [Description](#Description)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
    - [Prerequisites](#Prerequisites)
    - [Getting started with App](#getting-start)
    - [Client server communication](#Client-server-communication)
- [Project structure](#Project-structure)
- [project root folder](#project-root-folder)
- [Additional info](#info)
- [Author](#author)
- [License](#license)

# <a name="overview"></a> Overview
Mwani app is IOS app written in swift

# <a name="Description"></a> Description
Mwani Qatar app is responsible for managing the nation’s seaports and shipping terminals, but the integrated port and logistics services provider is also playing a more pivotal role. By substantially developing Hamad Port, the company is not only strongly positioned to develop a regional shipping hub in the region, but also to play a major role in diversifying the Qatari economy ready for a post-hydrocarbon future.

## Functionality provided
- login
- Vessel calls
- payments
- notifications
- Network Layer (API calls, SSL pinning, handle error logic, handle success logic)
- App Environment configuration (handle different app environment configuration "Dev-SIT-UAT-Prod" with different settings "server URL, port, certificate name, enable logging")
- Language Manager arabic & English(provide different language switching, RTL-LTR switching)
- Cashing Manager
- Security (provide some security check https, encryptions)
- Biometric (provide basic functionality for touch id / face id detection)

# <a name="requirements"></a> Requirements


- Xcode 14.2
- VPN connection
- GIT
- Github access
- UX access


# <a name="quick-start"></a> Quick Start

## <a name="getting-start"></a> Getting started with app

This Quick Start guide will get you up with the app

## <a name="Prerequisites"></a> Prerequisites

- Xcode 14.2
- VPN connection
- GIT
- Github access
- UX access

## <a name="getting-start"></a> Getting started with App

- Copy the code from git
- Build the project
- Run/Debug

## <a name="Client-server-communication"></a> Client server communication

RESTful architectural principle is used to achieve straightforward communication between client and server over HTTP protocol. Service factory on the client-side creates requests to the API interface on server and allows you to easily perform CRUD operations (create, read, update, delete) on server-side data.

Project contains a core folder which contains core functionalities common to the app features. Individual feature modules are developed in features folder

### Environment manager

Setting up multi configration, schema, and info files for the solution then use this functionality to read these environments 

```ruby
       
```

## <a name="Client-server-communication"></a> MVVM And Clean Code Architecture

Complete reference in how to build Clean Code Architecture and MVVM [here](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3).

# <a name="Project-structure"></a> Project structure
- Application main files
- dependency injection 
- features 
    - login (Data, Domain, Presentation)
    - home (Data, Domain, Presentation)
    - vssel calls (Data, Domain, Presentation)
- Core 
- Resources
- unit test
- UItest


# <a name="info"></a> Additional info

<!--Complete reference in how to config app for multiple configuration [here](https://medium.com/@aliakhtar_16369/managing-different-environments-using-xcode-build-schemes-and-configurations-af7c43f5be19). -->



# <a name="author"></a> Author

medhatali, medhat.ali@eg.ibm.com

# <a name="license"></a> License

(C) Copyright International Business Machines Corporation 2018. Licensed Material - Property of IBM - All Rights Reserved.


