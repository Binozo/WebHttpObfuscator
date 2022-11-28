# WebHttpObfuscator
Obfuscate your Http Requests on Flutter Web using the encryption of your choice and a middleman server

## Getting started

### Add dependency

```yaml
dependencies:
  web_http_obfuscator:
    git:
      url: https://github.com/Binozo/WebHttpObfuscator.git
      ref: master
```

### Setup your middleman server
See the [installation Guide](https://github.com/Binozo/WebHttpObfuscator-Server)

## Usage

```dart
final client = HttpObfuscatorClient(
    "ws://localhost:9268",
        (data) => yourEncryptionFunction(data),
        (data) => yourDecryptionFunction(data)
);
final response = await client.get("https://google.com/");
```
