# Introduction
This project is written as a coding challenge. Even though it's technically a complete app, it is not production ready. Anyone should be able to clone and build the project, and with little effort make it production ready.

Also note that the project is reliant on the package https://github.com/digital-fireworks/Rejseplanen, a swift package for integration to the public Rejseplanen API. However the supported version of the Rejseplanen API will be deprecated december 4th, 2024 and so this package will no longer work.

# What it does
The project builds an app for iOS 18 that fetches public transport information from the public api Rejseplanen, a danish company providing data for public transport such as stops, departures, trip information, adreess loogup etc.

The app aims at quickly providing location relevant information about nearby stops and the immediate departures from that stops. The purpose is to provide pendlers, that has a fairly good understanding of the danish public transport system, relevant information as fast as possible.

# How to build
To build the project, download the latest version of Xcode from developer.apple.com. Clone the repo and open the project in Xcode. Make sure, the package Rejseplanen is updated, by going to File -> Packages -> Resolve Package Versions. 

Make sure you have the right team and provisioning profile selected under Signing & Capabilites and change the bundle identifier to suit your needs. 

Build an run the project either in the simulaltor or on a provisioned device.
