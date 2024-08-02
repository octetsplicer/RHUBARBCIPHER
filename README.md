Languages: [English](README.md) | [한국어](README.ko.md)

# RHUBARBCIPHER
An experimental multi-key encryption/decryption system for GNU/Linux and BSD written in Ruby.

# WARNING
Please be aware that this gem has not undergone any form of independent security evaluation and is provided for academic/educational purposes only. It should be treated as a proof of concept and/or learning exercise. It is not recommended that RHUBARBCIPHER be used to encrypt any data with high confidentiality, availability or integrity requirements.

## Description
RHUBARBCIPHER is an experimental multi-key file encryption/decryption system for GNU/Linux and BSD that combines one-time pad encryption/decryption with Shamir's Secret Sharing in an attempt to encrypt files in a versatile yet information-theoretically secure manner.

It includes an optional decoy feature which allows users to specify a decoy file and generate a set of decoy keys in addition to the real keys. Size similarity between the decoy file and the real file is strictly enforced.

*Although RHUBARBCIPHER should technically work on larger files, it works best for smaller files (e.g. less than < 15000KiB) due to the amount of time taken to encrypt/decrypt data. The size of all keys combined is substantially greater than that of the original data. Additionally, the encryption or decryption of large files could potentially require more memory than your computer has available. For this reason, RHUBARBCIPHER should be used with caution.*

## Dependencies
* Ruby >= 2.5.5 (RHUBARBCIPHER has not been tested on anything below 2.5.5)
* CLOVERSPLITTER >= 0.2.1 (https://rubygems.org/gems/cloversplitter) (https://github.com/octetsplicer/CLOVERSPLITTER)
* SecureRandom (included in the Ruby Standard Library)
* Xorcist >= 1.1.2 (https://rubygems.org/gems/xorcist)

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

When run in decrypt mode (`-d` or `--decrypt`), RHUBARBCIPHER should produce a decrypted data file upon successful decryption.

For example, if one were to encrypt a file called `test` with a file called `test_decoy` specified as the decoy, and output everything into the current working directory, they could use the following command:

```
rhubarbcipher -e test -D test_decoy -o .
```

Using the above command should have produced 10 files starting with `real_key_`, 10 files starting with `decoy_key_` and one file starting with `encrypted_`.

To recover the real data, the user must use at least 5 out of the 10 real keys. For example:

```
rhubarbcipher -d encrypted_1591853713322 -k real_key_07_1591853713322,real_key_04_1591853713322,real_key_09_1591853713322,real_key_02_1591853713322,real_key_06_1591853713322 -o .
```

Recovering the decoy data works in exactly the same way, but the user must specify at least 5 decoy keys instead of real keys. For example:

```
rhubarbcipher -d encrypted_1591853713322 -k decoy_key_07_1591853713322,decoy_key_04_1591853713322,decoy_key_09_1591853713322,decoy_key_02_1591853713322,decoy_key_06_1591853713322 -o .
```

## Encryption Details
The following explanation of the RHUBARBCIPHER encryption system assumes that a decoy file has been specified in addition to the real file that the user wishes to keep secret.

RHUBARBCIPHER enforces a strict size similarity rule which dictates that the decoy file and the real file must be a similar size. Specifically, if `A` and `B` are the sizes of the decoy file and real file respectively in kibibytes (KiB), the following condition must be satisfied:

```
A\500 = B\500
```

Where `\` denotes integer division, which may be defined as follows:

```
A\B ≡ ⌊A/B⌋
```

When encrypting, RHUBARBCIPHER first generates *master-key alpha* (`mkey_alpha`), which is a random series of bytes produced by `SecureRandom.random_bytes(n)`. The size of `mkey_alpha` is chunked and should always be a multiple of 500 KiB. More specifically, the size of `mkey_alpha` is equal to `(A\500)·(500)` KiB.

`mkey_alpha` acts as a one-time pad (OTP) as every byte of the real file specified for encryption is XOR-ed with the corresponding byte in `mkey_alpha`, resulting in `real_data_encrypted`.

Random bytes are then appended to the end of `real_data_encrypted` such that it is precisely the same length as `mkey_alpha`.

After `real_data_encrypted` has been created, *master-key beta* (`mkey_beta`) is generated by XOR-ing every byte of the decoy file with `real_data_encrypted` and appending random bytes to the end until it is the same length as `mkey_alpha`.

A tag that includes version information and the length of the real file specified for encryption is then prepended to `mkey_alpha`.

A similar tag that includes version information and the length of the *decoy file* is prepended to `mkey_beta`.

Both `mkey_alpha` and `mkey_beta` are then split into 2000 separate 256B (2048-bit) pieces, with each piece being fed to CLOVERSPLITTER, which is a pure-Ruby implementation of Shamir's Secret Sharing.

CLOVERSPLITTER splits each individual piece of `mkey_alpha` and `mkey_beta` into 10 shares.

Effectively, `mkey_alpha` and `mkey_beta` are split into 10 separate sub-keys (which are simply referred to as *keys*).

In order to recover `mkey_alpha`, at least 5 of the 10 keys into which `mkey_alpha` was split are required.

Similarly, in order to recover `mkey_beta`, at least 5 of the 10 keys into which `mkey_beta` was split are required.

`real_data_encrypted` is then deflated with `zlib` and tagged with version information before being saved to a file in the output directory under a filename beginning with `encrypted_`.

Each key is similarly deflated with `zlib`, tagged with version information and saved to a file in the output directory. Real keys (derived from `mkey_alpha`) are saved under filenames beginning with `real_key_`, whereas decoy keys (derived from `mkey_beta`) are saved under filenames beginning with `decoy_key_`.

## Author
Copyright (C) 2020 Peter Bruce Funnell

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>
