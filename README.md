# swift-photos-05
iOS 연습 - 5팀(Elly, V)


## step1

완성날짜 03/22/2021

### 핵심 기능

- 스토리보드 ViewController에 CollectionView를 추가하고 Safe 영역에 가득 채우도록 frame을 설정한다.

- CollectionView Cell 크기를 80 x 80 로 지정한다.

- UICollectionViewDataSource 프로토콜을 채택하고 40개 cell을 랜덤한 색상으로 채우도록 구현한다.

  ### 실행화면

  

  <img width="300" src="https://user-images.githubusercontent.com/60229909/112099677-48cc8000-8be7-11eb-98fb-78045cf1d3fe.png">

  

## step2

완성날짜 03/23/2021

### 핵심기능

- UINavigationController를 Embed시키고, 타이틀을 'Photos'로 지정한다.
- PHAsset 프레임워크를 사용해서 사진보관함에 있는 사진 이미지를 Cell에 표시한다.
  - CollectionView Cell 크기를 100 x 100 로 변경한다.
  - Cell을 처리하기 위한 커스텀 클래스를 만들어서 지정한다.
  - Cell을 가득 채우도록 UIImageView를 추가한다.
- PHCachingImageManager 클래스를 활용해서 썸네일 이미지를 100 x 100 크기로 생성해서 Cell에 표시한다.
- PHPhotoLibrary 클래스에 사진보관함이 변경되는지 여부를 옵저버로 등록한다.



### 실행화면

<img width="300" src = "https://user-images.githubusercontent.com/60323625/112099350-b6c47780-8be6-11eb-9a4c-f7f622e2caf7.png">
