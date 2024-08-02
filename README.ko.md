[English](README.md) | [한국어](README.ko.md)

# RHUBARBCIPHER (루바브사이퍼)
GNU/리눅스 및 BSD를 위한 실험적인 암호화 도구

# 주의
이 도구는 교육적인 목적으로 제공되었으며 외부 보안 평가를 받지 못했습니다. 그러므로 이 도구로 기밀성/무결성/가용성의 요구가 높은 데이터를 암호화시키는 것을 추천하지 않습니다.

## 주요 기능의 요약
RHUBARBCIPHER는 GNU/리눅스 및 BSD 운영체계를 위한 실험적인 암호화 도구입니다. 암호화 단계에는 먼저 유사난수생성기로 *일회성 패드*를 생성해 파일을 암호화합니다. 그 다음에 *샤미르 비밀 공유*란 알고리즘을 써서 해당 일회성 패드를 여러 키로 나눕니다. 사용자가 실제 파일을 암호화할 때 유인용(誘引用) 파일도 같이 정하실 수 있는데 유인용 파일을 정하시는 경우에 유인용 키 10개, 실제 키 10개가 생성됩니다. 실제 파일을 복호화하려면 실제 키 5개 이상이 무조건 필요하고, 유인용 파일을 복호화하려면 유인용 키 5개 이상 필요합니다.

*RHUBARBCIPHER는 암호화 또는 복호화를 할 때 시간이 비교적 오래 걸릴 수 있으며 15000KiB이상인 파일의 암호화 또는 복호화를 삼가시는 것을 추천하고 싶습니다. RHUBARBCIPHER가 활용하는 알고리즘의 단점 중에 키 파일이 아주 크게 나온다는 점이 있으니 파일 사이즈에 특히 신경을 쓰시는 것도 추천하고 싶습니다. 큰 파일을 암호화 또는 복호화하시는 경우에 컴퓨터의 사용 가능한 RAM보다 더 많은 RAM이 필요할 수도 있으니 사용 전에 이 점에 특히 주의해 주시기 바랍니다.*

## 의존 라이브러리 및 소프트웨어
* Ruby >= 2.5.5
* CLOVERSPLITTER >= 0.2.1 (https://rubygems.org/gems/cloversplitter) (https://github.com/octetsplicer/CLOVERSPLITTER)
* SecureRandom (Ruby의 표준 라이브러리에 포함)
* Xorcist >= 1.1.2 (https://rubygems.org/gems/xorcist)

## 설치하는 법
RHUBARBCIPHER는 다음과 같은 방법으로 설치됩니다:
```
gem install rhubarbcipher
```

## 사용하는 법
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

파일을 암호화하려면 `-e` 또는 `--encrypt`란 명령행 인자로 파일을 정하시고 `-o` 또는 `--output`이란 인자로 *생산 디렉터리*를 정하시면 됩니다.

유인용 키도 같이 생성하시려면 `-D` 또는 `--decoy`란 인자를 사용해서 유인용 파일도 정하셔야 됩니다. (*암호화 설명문*에 나오다시피 유인용 파일은 실제 파일과 비슷한 사이즈여야 합니다.)

유인용 파일을 정해도 정하지 않아도 실제 키가 10개 생성됩니다. 실제 파일을 복호화하려면 그 10개 중에 최소한 5개를 가지고 있어야 합니다.

유인용 파일을 정하면 추가로 유인용 키도 10개 생성됩니다.

암호문을 복호화할 때 `-d` 또는 `--decrypt`란 인자로 암호문 파일을 정하시고 `-k` 또는 `--keys`란 인자를 써서 쉼표(`,`)로 구분한 키 목록도 정하셔야 됩니다. (*게다가 파일을 암호화할 때랑 마찬가지로 `-o` 또는 `--output` 인자를 써서 생산 디렉터리도 정하셔야 됩니다.*)

복호화 시도를 하실 때 실제 키 5개 이상 쓰면 실제 파일이 나오고 유인용 키 5개 이상 쓰면 유인용 파일이 나옵니다.

예를 들면 실제 파일인 `test`를 암호화하고 싶은데 `test_decoy`란 유인용 파일도 쓰고 암호문과 모든 키를 현재 작업 디렉터리에 저장하고 싶다면 다음과 같은 명령을 입력하시면 됩니다:

```
rhubarbcipher -e test -D test_decoy -o .
```

파일 이름은 실제 키의 경우에 `real_key`로 시작하고 유인용 키의 경우에 `decoy_key_`로 시작합니다. 암호문의 경우에는 단순히 `encrypted_`로 시작합니다.

실제 키 5개를 사용해서 실제 파일을 복호화하려면 다음과 같은 명령을 쓰시면 됩니다:

```
rhubarbcipher -d encrypted_1591853713322 -k real_key_07_1591853713322,real_key_04_1591853713322,real_key_09_1591853713322,real_key_02_1591853713322,real_key_06_1591853713322 -o .
```

유인용 파일을 복호화하려는 경우에는 비슷하게 유인용 키를 쓰시면 됩니다:

```
rhubarbcipher -d encrypted_1591853713322 -k decoy_key_07_1591853713322,decoy_key_04_1591853713322,decoy_key_09_1591853713322,decoy_key_02_1591853713322,decoy_key_06_1591853713322 -o .
```

## 암호화 설명문
유인용 파일을 정하시는 경우에 RHUBARBCIPHER가 아래와 같은 방법으로 암호화를 실행합니다.

정보를 보호하기 위해 유인용 파일 및 실제 파일이 비슷하여야 한다는 엄격한 규칙이 있습니다.

유인용 파일 및 실제 파일의 사이즈를 `A` 및 `B`로 표시하자면 다음과 같은 조건이 반드시 충족되어야 합니다:

```
A\(500KiB) = B\(500KiB)
```

`\`란 기호는 *정수 나누기 연산*을 나타냅니다:

```
A\B ≡ ⌊A/B⌋
```

RHUBARBCIPHER는 파일을 암호화할 때 먼저 Ruby 표준 라이브러리에 포함돼있는 유사난수생성함수인 `SecureRandom.random_bytes(n)`를 활용해서 `mkey_alpha`란 키를 생성합니다. `mkey_alpha`의 사이즈는 `(A\500)·(500)` KiB과 동등하여 항상 500 KiB의 배수입니다.

`mkey_alpha`는 생성 직후에 일회성 패드로 쓰입니다. 실제 파일 속에 있는 데이터가 각 바이트마다 `mkey_alpha`의 해당 바이트와 XOR되어 `real_data_encrypted`란 암호문이 나옵니다.

`real_data_encrypted`가 `mkey_alpha`랑 같은 사이즈가 될 때까지 끝에다가 무작위로 생성된 바이트가 추가됩니다.

`real_data_encrypted`가 생성되고 나서 유인용 파일이 `real_data_encrypted`와 XOR되어 `mkey_beta`란 유인용 일회성 패드가 나옵니다.

`mkey_beta`도 `mkey_alpha` 하고 `real_data_encrypted`랑 같은 사이즈가 될 때까지 끝에다가 무작위로 생성된 바이트가 추가됩니다.

`mkey_alpha` 및 `mkey_beta`에다가 프로그램 버전 및 해당 파일의 사이즈를 알리는 메타데이터 태그가 추가됩니다.

그 다음에 `mkey_alpha` 및 `mkey_beta`가 CLOVERSPLITTER란 *샤미르 비밀 공유* 라이브러리를 통해서 여러 키로 나눠집니다.

`mkey_alpha`로는 실제 키 10개가 만들어지고 `mkey_beta`로는 유인용 키 10개가 만들어집니다.

실제 파일을 복호화하기 위해서는 실제 키 5개 이상이 필요하며 유인용 파일을 복호화하기 위해서는 비슷하게 유인용 키 5개 이상이 필요합니다.

## 저작권
Copyright (C) 2020 Peter Bruce Funnell

## 라이센스 정보
이 프로그램은 자유 소프트웨어입니다. 소프트웨어 피이용허락자는 자유 소프트웨어 재단이 공표한 GNU GPL 3판 또는 그 이후 판을 임의로 선택해, 그 규정에 따라 프로그램을 개작하거나 재배포할 수 있습니다.

이 프로그램은 유용하게 사용되리라는 희망으로 배포되지만, 특정한 목적에 맞는 적합성 여부나 판매용으로 사용할 수 있다는 묵시적인 보증을 포함한 어떠한 형태의 보증도 제공하지 않습니다. 보다 자세한 사항은 GNU GPL을 참고하시기 바랍니다.

GNU GPL은 이 프로그램과 함께 제공됩니다. 만약 이 문서가 누락되어 있다면 <https://www.gnu.org/licenses/>를 보아주십시오.
