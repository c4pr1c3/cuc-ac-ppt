---
title: "在应用开发项目中如何安全实现密码学算法"
author: 黄玮
output: revealjs::revealjs_presentation
---

# TL; DR

---

> Too Long; Don't Read

[LibSodium](https://github.com/jedisct1/libsodium)

[LibSodium](https://github.com/jedisct1/libsodium)

[LibSodium](https://github.com/jedisct1/libsodium)

# 为什么不推荐使用 XXX

---

* [PHP - Mcrypt](http://php.net/manual/zh/book.mcrypt.php) ?
* [OpenSSL](https://www.openssl.org/) ?
* [Java / C# - Bouncy Castle](https://www.bouncycastle.org/) ?
* [Google 出品 KeyCzar](https://github.com/google/keyczar) ?
* [pycrypto](https://pypi.org/project/pycrypto/) ?

---

## XXX 普遍存在的问题

* 提供已证明不安全的密码学算法的实现且未给予相应的易于理解警示或警告
    * MD5 / SHA-1 / DES / ECB 模式的对称加密算法
* 提供的是不规范、不健壮的密码学算法实现
    * [Mcrypt 提供的对称加密算法使用 `NULL` 字符填充](http://php.net/manual/zh/function.mcrypt-encrypt.php)
    * [消息验证码验证算法存在「Timing Attack」缺陷](https://codahale.com/a-lesson-in-timing-attacks/)，
* 提供的是 **最基础** 的密码学算法实现，对于没有密码学专业背景的程序员来说容易编写出存在缺陷的密码学算法
    * 缺少提供符合 [AEAD](https://en.wikipedia.org/wiki/Authenticated_encryption) 标准的数据加密算法 API
* 停止更新或长时间无人维护更新
    * [pycrypto](https://pypi.org/project/pycrypto/)
    * [Mcrypt Known Open Bugs](https://sourceforge.net/p/mcrypt/bugs/)

---

## 为什么没有首先推荐 [NaCl](http://nacl.cr.yp.to/)

* 优秀的加密算法实现库
* 除非你
    * 使用 C/C++ 开发的应用
    * 使用 Python 开发的应用可以使用 [PyNaCl](https://github.com/pyca/pynacl)
        * [延伸阅读 - Python 的密码学算法选型依据](https://github.com/c4pr1c3/ac-demo/tree/master/examples/python)
* [LibSodium](https://github.com/jedisct1/libsodium) 是基于 NaCl 开发的，与 NaCl **100%** API 兼容，扩充了一些新特性，提供[更好的跨平台移植性](https://download.libsodium.org/doc/bindings_for_other_languages/index.html)
* PHP 是主流编程语言里第一个在语言标准库里内置集成了对 [LibSodium](https://github.com/jedisct1/libsodium) 的 API 绑定实现支持

# 为什么强烈推荐 LibSodium

---

## 顶尖专业团队出品

基于 NaCl 开发，而 NaCl 作者团队拥有三位顶尖密码学专家

* [Dan Bernstein](http://cr.yp.to/) 椭圆曲线加密和签名算法 Curve25519, Ed25519 的作者，开发了 qmail, djbdns 等知名以安全著称的流行开源互联网基础设施软件
* [Tanja Lange](https://hyperelliptic.org/) 椭圆曲线加密和签名算法专家
* [Peter Schwabe](https://cryptojedi.org/peter/index.shtml) 擅长密码学侧信道分析

---

* LibSodium 的项目领导者 [Frank Denis](https://github.com/jedisct1) 是一名活跃的优秀开源软件开发者和安全专家。
    * [强烈推荐阅读 Frank Denis 在 2017 年 hack.lu 上的一次关于「密码学算法实现 API 设计方法」的技术分享](https://2017.hack.lu/archive/2017/hacklu-crypto-api.pdf)
* 在该项目[算法设计者和开发者名单里](https://github.com/jedisct1/libsodium/blob/master/AUTHORS) 我们依然可以看到 NaCl 的三位作者（特别是 [Dan Bernstein](http://cr.yp.to/)）均赫然在列。

---

## 优秀的算法设计 + [健壮的代码实现](https://download.libsodium.org/doc/internals/)

* 具备健壮性和一致性密码学特征的简单接口
* 每一步计算操作均采用了「常量化」耗时处理（对抗「Timing Attack」）
* 与 [WebCrypto](https://w3c.github.io/webcrypto/) 这种由「委员会」票选出来的一堆流行密码学算法大杂烩不同，libsodium 的密码原语和构造都经过精心挑选，并且明确声明了它们的真实世界软件应用的安全属性
* libsodium 的实际安全性能表现优于美国国家标准技术研究所（NIST）的联邦信息处理标准 (Federal Information Processing Standard, FIPS) 标准

---

## 哪些情况下你无法选择 libsodium

* 各个国家的密码学算法标准合规性要求实现的算法在 libsodium 中没有获得实现支持
* 你选择的编程语言还没有对应的封装 API 可用
* [强加密算法使用属于违法行为的某些场景](https://docs.microsoft.com/zh-cn/windows/uwp/security/export-restrictions-on-cryptography)
* 强制兼容老旧不安全密码学算法的需求场景

# PHP

---

* [Frank Denis 亲自操刀主持的 libsodium PHP 移植实现](https://pecl.php.net/package/libsodium)
* [PHP Libsodium 最详细文档 by Paragon Initiative Enterprises](https://paragonie.com/book/pecl-libsodium)
* [密码学意义上的 PHP 安全开发 by Paragon Initiative Enterprises 2017-02-09](https://paragonie.com/blog/2017/02/cryptographically-secure-php-development)
* [Halite - libsodium PHP 实现的更进一步封装 API](https://github.com/paragonie/halite)
    * 在基础 libsodium 功能的基础上进一步封装了[常用 Web 服务端功能 API](https://github.com/paragonie/halite/blob/master/doc/Features.md)：Cookie加密与解密、文件加密与解密、口令存储与验证

# Python

---

* [常见密码学算法 Python 版示例](https://github.com/c4pr1c3/ac-demo/tree/master/examples/python)


# 其他主流编程语言的密码学库

---

* [C++ - Crypto++](https://www.cryptopp.com/)
    * 跨平台第三方支持，丰富且持续更新的现代密码学 API 实现和完善文档
* [Java Cryptography Architecture (JCA) ](https://docs.oracle.com/javase/8/docs/technotes/guides/security/crypto/CryptoSpec.html)
    * 不愧为企业级开发市场的王者，官方支持的丰富且持续更新的现代密码学 API 实现和完善文档

---

* [Javascript - Web Crypto API（W3C Recommendation 2018.6）](https://www.w3.org/TR/WebCryptoAPI/) | [libsodium.js](https://github.com/jedisct1/libsodium.js)
    * 浏览器即将提供原生的现代密码学 API 支持，部分现代浏览器已提供了 API 实现
* [.NET - System.Security.Cryptography](https://docs.microsoft.com/zh-cn/dotnet/api/system.security.cryptography)
    * 现代密码学 API 支持并不完善（例如不支持 AES-GCM）

# 其他主流平台的安全编程实践

---

* [安全 Windows 应用开发简介 from MSDN](https://docs.microsoft.com/zh-cn/windows/uwp/security/intro-to-secure-windows-app-development)
* [苹果公司的密码学相关服务开发指南 from developer.apple.com](https://developer.apple.com/library/archive/documentation/Security/Conceptual/cryptoservices/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011172-CH1-SW1)
* [Android App 开发最佳安全实践 from developer.android.com](https://developer.android.com/topic/security/best-practices)

