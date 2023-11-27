# RP2040 Implementation for SCounter

This software is using [rp2040-hal template](https://github.com/rp-rs/rp2040-project-template) in MIT license. See the original template for more information on embedded rust and prepairing your dev-env.

## Requirements

ビルド/使用には以下のソフトウェア等が必要です。

- Rustツールチェーン
  - cargo
  - rustup
  - rustc
- thumbv6m-none-eabi (build target)
- flip-link
- elf2uf2-rs
- 仕様に適合するボード

必要なものは以下のコマンドでインストール出来ます。  
このソフトウェアはprobe-rsを用いていません。もしprobe-rsを使用したいなら、`.cargo/config.toml`の`runner`変数を編集してください。また、probe-rsの利用のためには`cargo install`が必要です。

```sh
rustup target install thumbv6m-none-eabi
cargo install flip-link
cargo install elf2uf2-rs --locked
```

## 仕様

外部集中端子板 「Ⅵ3型」(以下端子板) の出力をUSB経由のシリアルでホストコンピューターに出力します。  
PINアサインは以下のとおりです。

```
GPIO17 = 端子板1pin
GPIO18 = 端子板2pin
GPIO19 = 端子板3pin
GPIO20 = 端子板4pin
GPIO21 = 端子板5pin
GPIO22 = 端子板7pin
GPIO23 = 端子板8pin
```

端子板6pinはコモン(GND)です。  
それぞれのピンからどの信号が出力されるかは各自で調べてください。([A-slot](https://www.a-slot.com)の台ページ下部に出力信号表が記載されていることが多いので参考にしてください。)このソフトウェアは単に、出力された信号を変換してホストコンピューターに送信することしか行いません。

このソフトウェアはプルアップ抵抗を用いることを想定しています。内部プルアップは用いていませんので、基盤を作成する際はプルアップ抵抗を設置してください。信号pin数から、集合抵抗などを用いると便利です。

## License

The contents of this software for RP2040 board are licensed under MIT License. See `MIT` for more information.