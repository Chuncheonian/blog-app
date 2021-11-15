# 스마일게이트 스토브 데브캠프 사전과제

<p align="center">
  <img src="https://img.shields.io/badge/Swift-v5.5-red?logo=swift" />
  <img src="https://img.shields.io/badge/Xcode-v13.0-blue?logo=Xcode" />
  <img src="https://img.shields.io/badge/iOS-14.0+-black?logo=apple" />
</p>

## 과제 소개

**Auth, NoSQL기반 DB, Storage 백엔드 기능을 제공하는 Firebase를 사용하여 UIKit 프레임워크로 나만의 블로그 iOS App을 제작하였습니다.**

> 📆 2021.10.30 ~ 2021.11.05

<br />

## Directory Architecture

* MVVM 아키텍처를 적용하였습니다.

```shell
blog-app
├── Model
│   └── ...
├── View
│   └── ...
├── ViewModel
│   └── ...
├── Controller
│   └── ...
├── API                        ---> Firebase 관련
│   └── ...
├── Util
│   └── ...
├── AppDelegate.swift
├── SceneDelegate.swift
├── Info.plist
└── GoogleService-Info.plist
```

<br />

## BackEnd Architecture

### Database
```shell
Firestore
├── users
│   ├── uid (PK)
│   ├── email
│   ├── name
│   ├── biography
│   └── profileImageURL
│
└── posts ─────────── comments
    ├── uuid (PK)     ├── uid
    ├── title         ├── name
    ├── content       ├── content
    ├── imageURL      └── timestamp
    ├── commentCount
    ├── timestamp
    ├── ownerUID
    └── ownerName        
```

### Storage

```shell
Storage
├── profile_images
│   └── user의 uid로 프로필 이미지 관리
│
└── post_images
    └── post의 uuid로 게시물 이미지 관리
```

<br />

## 기능 구현

**필수 SPEC:**

- [x] 메인 페이지
- [x] 글 쓰기 수정 기능
- [x] 글 목록 삭제 기능
- [x] 댓글 기능

**옵션 SPEC:**

- [x] UI 디자인
- [x] 관리자 도구
- [ ] Trackback
- [ ] RSS

<br />

SPEC | GIF
| :-----------------: | :------------------------------------------: |
**메인 페이지** | <img src="./img/main-page.gif" width="25%" />
**글 쓰기 수정 기능** | <img src="./img/upload-update-post.gif" width="25%" />
**글 목록 삭제 기능** | <img src="./img/delete-post.gif" width="25%" />
**댓글 기능** | <img src="./img/comment.gif" width="25%" />
**관리자 도구** | <img src="./img/manager-mode.gif" width="25%" />


<br />

## 사용한 라이브러리

```
* Parchment       # PagingView
* Firebase        # 백엔드 기능
* Kingfisher      # 이미지 캐싱
* JGProgressHUD   # 로딩 뷰
```

