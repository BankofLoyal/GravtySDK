// This file exists solely to give SwiftPM a regular target that can declare the
// package dependencies inherited from GravtySDK.podspec (Moya,
// SwiftKeychainWrapper, AnyCodable). The binary target `GravtySDK` cannot
// declare those dependencies directly, so this wrapper does so and re-exports
// the binary module. Consumers should continue to `import GravtySDK`.

@_exported import GravtySDK
