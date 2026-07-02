# Tanzu Standard Air-Gap / Package Management Scripts

구성은 아래처럼 나뉩니다.

- `bin/airgap-image-registry-push.sh`
  - Broadcom Tanzu Standard repo tag 조회
  - 선택한 tag를 tar로 export
  - tar 파일을 Harbor registry로 push
- `bin/tanzu-standard-package-manager.sh`
  - namespace 선택
  - package repository add/update/list
  - available package list
  - package install/update/delete
  - installed package 전체 목록 확인
  - default values file 추출
- `lib/common.sh`
  - 공통 함수
  - 선택 메뉴/프롬프트 UI를 stderr로 출력해서 `$(...)` 캡처값에 메뉴 문구가 섞이지 않도록 처리

## 전제 조건

### airgap-image-registry-push.sh
- `imgpkg` 설치 완료
- Broadcom source registry 접근 가능
- Harbor registry 인증은 사전에 `docker login` 또는 registry credential 설정이 되어 있다고 가정
- CA 인증서는 기본값 `/home/moon/certs/ca-git.crt`

### tanzu-standard-package-manager.sh
- `tanzu` CLI 설치 완료
- `kubectl` context가 대상 cluster로 설정 완료
- package plugin 사용 가능
- 대상 namespace는 이미 존재한다고 가정

## 사용 방법

```bash
chmod +x bin/*.sh lib/*.sh
./bin/airgap-image-registry-push.sh
./bin/tanzu-standard-package-manager.sh
```

## 이번 수정 사항

- 초기 namespace 선택 시 메뉴 문구가 변수에 섞여 들어가던 문제 수정
- 선택 메뉴는 항상 아래 흐름으로 표시되도록 정리
  - 항목 목록 출력
  - `번호를 선택하세요:` 입력
  - `0) 취소` 지원
- package install/update/delete 시 현재 선택한 대상 정보를 먼저 보여준 뒤 명령 실행
- package/version 자동 조회가 실패하면 직접 입력으로 fallback
- air-gap tar export/import 모두 `--cosign-signatures` 사용

## 참고 사항

### 1) repository add / update URL
offline Harbor registry를 repo로 쓰는 경우 URL은 보통 다음 형식입니다.

```text
<harbor-host>/<project>/packages/standard/repo:<repo-tag>
```

예시:

```text
harbor.example.com/tanzu/packages/standard/repo:v2024.5.16
```

### 2) default values file 추출
스크립트는 아래 명령 형태를 사용합니다.

```bash
tanzu package available get <package-name>/<version> --default-values-file-output <output-file> -n <namespace>
```

### 3) install / update values 파일
install/update 시 values 파일 사용 여부를 먼저 물어보고,
`yes` 선택 시 실제 파일 경로를 입력받습니다.

### 4) installed package delete / update
삭제와 업데이트는 실제 Tanzu 동작 방식에 맞게 설치된 package instance 이름으로 실행됩니다.
다만 스크립트에서는 먼저 `패키지 명`을 고르고, 그 다음 `설치이름 | 현재버전`을 고르도록 구성했습니다.

## 권장 실행 순서

1. `airgap-image-registry-push.sh`로 repo tar export 및 Harbor push
2. `tanzu-standard-package-manager.sh`로 namespace 선택
3. package repository add 또는 update
4. available package 확인
5. install / update / delete 수행