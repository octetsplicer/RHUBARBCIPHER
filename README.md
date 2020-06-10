# RHUBARBCIPHER
A plausibly deniable multi-key encryption/decryption system for GNU/Linux and BSD written in pure Ruby.

# WARNING
Please be aware that this gem has not undergone any form of independent security evaluation.

## Description
RHUBARBCIPHER is a plausibly deniable multi-key file encryption/decryption system for GNU/Linux and BSD that combines one-time pad encryption/decryption with Shamir's Secret Sharing in an attempt to encrypt files in a versatile yet information-theoretically secure manner. It includes an optional decoy feature which allows users to specify a decoy file and generate a set of decoy keys in addition to the real keys. Size similarity between the decoy file and the real file is strictly enforced.

## Dependencies
* Ruby >= 2.5.5 (RHUBARBCIPHER has not been tested on anything below 2.5.5)
* CLOVERSPLITTER >= 0.2.1 (https://rubygems.org/gems/cloversplitter) (https://github.com/octetsplicer/CLOVERSPLITTER)
* SecureRandom (included in the Ruby Standard Library)

## Installation
RHUBARBCIPHER can be installed as follows:
```
gem install rhubarbcipher
```

## Usage
```
Usage: rhubarbcipher [OPTIONS]

    -h, --help                       Display help text and exit.

    -v, --version                    Display version information and exit.

    -e, --encrypt FILE               Encrypt the specified file. An output directory must be specified with '-o' or '--output'.

    -d, --decrypt FILE               Decrypt the specified file. An output directory must be specified with '-o' or '--output'.

    -D, --decoy FILE                 Specify a decoy file for plausibly deniable encryption.

    -k, --keys KEYS                  Specify a comma-separated list of keys.

    -o, --output DIR                 Specify an output directory. If the directory already exists, files may be overwritten.

```

Users may optionally specify a decoy file for generating decoy keys.

Master-keys (whether decoy or real) are split into 10 keys, which may be distributed (or not) at the user's convenience.
A minimum of 5 keys are required in order to recover the master-key to which those keys pertain.

When run in encrypt mode (`-e` or `--encrypt`), RHUBARBCIPHER should produce an encrypted data file as well as 10 keys (5 of which are required for recovery). If a decoy file was specified, 10 decoy keys will also be generated (5 of which are required for recovery of the decoy data).

When run in decrypt mode (`-e` or `--decrypt`), RHUBARBCIPHER should produce a decrypted data file upon successful decryption.

## Author
Copyright (C) 2020 Peter Bruce Funnell

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>

## Support
If you found this project useful and would like to encourage me to continue making open source software, please consider making a donation via the following link:

https://www.buymeacoffee.com/peterfunnell

Donations in Bitcoin (BTC) are also very welcome. My BTC wallet address is as follows:

```
3EdoXV1w8H7y7M9ZdpjRC7GPnX4aouy18g
```
