# ShoppingList


https://user-images.githubusercontent.com/80672561/140287751-48d55fdd-b960-49a5-8d07-92289d48e770.mov


https://user-images.githubusercontent.com/80672561/140074956-7795dd91-fa96-42fb-9160-5ec54e033b01.mov


https://user-images.githubusercontent.com/80672561/140075005-0ec5ffa1-6a1d-4d69-8a42-1ebff9188ee8.mov

## 사용한 것
- Day26
- [x] Realm
- [x] Alert
- [x] ActionSheet
- [x] UITableView -> Edit, Swipe

- Day27
- [x] FileManager 
- [x] zip
- [x] MobileCoreServices


## 주요 기능
Day26
- MongoDB, Realm을 활용한 쇼핑 리스트 추가 기능
- UserDefaults는 String, Int 등의 간단한 단일 데이터를 저장하는데 적합하기 때문에, 객체 형태로 여러 데이터를 저장하고 관리하는데 어려움이 있음..

Day27
- 백업하기, 복구하기 print를 찍었을 때 잘 나왔늗네 테이블뷰에 갱신이 안됨.. --> 해결 필요!!!

## 리팩토링
- [ ] sorterd(byKeyPath: , ascending)을 해서 구현했는데 다시 수정하는 것 까지는 구현하지 못함..
- [ ] 복구하기를 누른 후 테이블뷰에 갱신이 안됨 --> 수정 필요
- [ ] 백업하기, 복구하기 카카오톡을 봤는데 테이블뷰를 사용했고 비밀번호 확인란까지 있어서 이 부분을 참고해서 리팩토링 할 예정

## 시간 잡아 먹은 부분
1. 시간을 가장 많이 잡아 먹은 부분이,, 우선 폴더를 옮겨서 경로 에러가 발생해서 수정하는데 한참 걸림 ...
2. 정렬하는 부분에서 sort를 사용하면 된다는 것은 알았는데 찾아보는데 꽤 걸림
3. 과제하면서 제일 화난 부분이 .. 처음에 Cocoapods으로 Realm을 사용했는데 ㅋㅋ 
  푸시할라고 하니까 100MB 넘어서 git-lfs로 ,, 해결할라 했는데 이게 잘 안되가꼬 SPM으로 다시 설치해서 사용했는데 ..
  UptoNextMajorVersion으로 설치했는데 계속 에러가 발생했음.. 결국 Dependency Rule을 Branch로 바꿔서 해결..
  
