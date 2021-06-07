---
title: "密码学应用实践"
author: 黄玮
output: revealjs::revealjs_presentation
---

# 检查一下各位学的是不是「真」密码学

# 第一波问题：对称加密

---

## 以下哪些是个人「密码」管理软件

* A. LastPass
* B. 1Password
* C. Notepad
* D. KeePass

---

## 以下哪些工作模式可以用于 AES 分组加密？

* A. ECB
* B. CBC
* C. GCM
* D. CCM

---

## 密码管理软件中对用户「密码」的加密

使用的可能是什么加密算法？

---

## 设置的「主密码」能直接用于加密「密钥」吗？

提示：

1. 你学过的对称加密算法是否有限制密钥长度？
2. 你用过的密码管理软件限制过你使用的「主密码」长度？

<center>![](images/wtf.jpeg)</center>

---

## 加密消息的接收方如何确认解密成功？消息无篡改？

---

## 加密消息用的「密钥」如何安全保存？

# 第二波问题：非对称加密

---

## 在互联网中如何用密码学方法证明「你」是「你」？

---

## 如何证明「CA」是**真**「CA」、「证书」是**真**「证书」

# 小学期的编程环境

---

## 🌰

---

### 开发环境配置

* VS Code + VS Code Remote
* [数据库管理软件 - Adminer](https://hub.docker.com/_/adminer)

---

### 运行环境配置

* Docker + 定制服务端脚本运行环境
    * [Python](https://hub.docker.com/_/python)
    * [PHP](https://hub.docker.com/_/php)
    * [MySQL](https://hub.docker.com/_/mysql)

---

### 业务知识

* Applied Cryptography

---

### 推荐搜索关键词

```
业务关键词 + 以下通用修饰关键词
```

* tutorial / guide / step by step
* cheatsheet / manual / awesome
* example / sample / howto
* comparison / benchmark / versus
* top 10

---

### 延伸阅读

[技术选型推荐](Implementation.md.html)

