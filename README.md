# ShoppingList

https://user-images.githubusercontent.com/80672561/140074956-7795dd91-fa96-42fb-9160-5ec54e033b01.mov
https://user-images.githubusercontent.com/80672561/140075005-0ec5ffa1-6a1d-4d69-8a42-1ebff9188ee8.mov

## 사용한 것
- [x] Realm
- [x] Alert
- [x] ActionSheet
- [x] UITableView

## 주요 기능
MongoDB, Realm을 활용한 쇼핑 리스트 추가 기능
UserDefaults와 Realm의 차이점 
UserDefaults는 String, Int 등의 간단한 단일 데이터를 저장하는데 적합하기 때문에, 객체 형태로 여러 데이터를 저장하고 관리하는데 어려움이 있음..


## 리팩토링
- [ ] sorterd(byKeyPath: , ascending)을 해서 구현했는데 다시 수정하는 것 까지는 구현하지 못함..

## 시간 잡아 먹은 
1. 시간을 가장 많이 잡아 먹은 부분이,, 우선 폴더를 옮겨서 경로 에러가 발생해서 수정하는데 한참 걸림 ...
2. 정렬하는 부분에서 sort를 사용하면 된다는 것은 알았는데 찾아보는데 꽤 걸림
3. 과제하면서 제일 화난 부분이 .. 처음에 Cocoapods으로 Realm을 사용했는데 ㅋㅋ 
  푸시할라고 하니까 100MB 넘어서 git-lfs로 ,, 해결할라 했는데 이게 잘 안되가꼬 SPM으로 다시 설치해서 사용했는데 ..
  UptoNextMajorVersion으로 설치했는데 계속 에러가 발생했음.. 결국 Dependency Rule을 Branch로 바꿔서 해결..
  
