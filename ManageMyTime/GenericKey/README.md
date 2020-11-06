# Generic Keychain: An example of how to use Keychain Services on iOS.

This sample demonstrates how to use the Keychain Services API to store, update and delete generic password keychain items.

## Requirements

### Build

Xcode 8.0, iOS 9.0 SDK or later

### Runtime

iOS 9.0 or later

## Overview

The sample has two application targets. Each target has same Keychain Group specified in its entitlements. This allows items to be shared between both appilcations.

The KeychainPasswordItem struct provides a high-level interface to the Keychain Services API calls required to interface with the iOS keychain. The passwords for keychain item are not stored as properties of the struct, instead they are only ever read from the keychain on demand.


Copyright (C) 2016 Apple Inc. All rights reserved.
