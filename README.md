# War3-Work-released-as-open-source

<br>
<br>
<br>

오픈소스로 공개한 워크래프트3 작업물들

<br>
<br>
<br>
<br>
<br>
<br>

### 스탯창과 스탯찍기

<br>

![1](https://github.com/user-attachments/assets/8772dc94-8e1a-46fb-91f5-739543172b3c) <br>

![2](https://github.com/user-attachments/assets/df422e25-9931-4e99-9123-206351f02589)


플레이어 별로 다른 수치가 보이도록 만들어진 UI

프레임관련 작동은 비동기로 이루어지며, 게임 전체 로직에 영향을 주는건 동기화됨

<br>
<br>
<br>
<br>
<br>
<br>

### 동기화된 마우스 좌표함수

<br>

![3](https://github.com/user-attachments/assets/6e8865cb-0774-4d7c-ab44-0a440e61c775) <br>


워크래프트의 마우스좌표 함수를 동기화 영역에서 바로 사용해버리면, 오류가 발생함

비동기로 마우스 좌표를 구하고 

이 값을 사용하기 위해서 동기화 시킴

<br>
<br>
<br>
<br>
<br>
<br>

### 개선된 진동함수

<br>

![4](https://github.com/user-attachments/assets/ddaff1b6-a008-4563-951c-0c4be92a6fe7)

워크래프트 자체 진동함수는

여러개의 진동이 작용되었을 때, 제일 나중에 있는 진동으로 덮혀버림

이러면 문제점이 발생하는데,

예를들어 강력한 스킬효과로 전체 유저에게 오래 지속되는 강력한 진동효과를 주었다 가정하면

이후 아주 작은 진동 함수만 발동되어도 금방 끊기게 된다

그래서 이 문제를 해결하기위해 진동 정보를 해쉬테이블에 저장해서 조회 하는 방식으로 래퍼를 씌우고

진동세기, 진동 지속시간을 고려한 로직이 적용됨

<br>
<br>
<br>
<br>
<br>
<br>

### 외부 링크 UI

<br>

![5](https://github.com/user-attachments/assets/bef9da39-c6e2-4d05-a0e9-a6744594a9b5)

설정한 외부링크를 열어주는 UI

<br>
<br>
<br>
<br>
<br>
<br>

### 유닛 텔포 시스템

<br>

![6](https://github.com/user-attachments/assets/8d03f9a5-6cc1-415d-a24f-9bc27bb950ca)

구역 입장시 유닛을 텔레포트 시켜주는 시스템

워크에서 해당 로직을 구현하려면 번거럽고 까다로움

그래서 단순 함수 한줄로 해당 기능을 구현하도록 래퍼를 씌운 시스템

<br>
<br>

<img width="400" height="130" alt="스크린샷 2025-08-31 211414" src="https://github.com/user-attachments/assets/d28673a5-29bd-493b-a93a-0ee51c489aac" />

위 gif를 구현하는데 함수 4줄만 쓰면 가능하게 됨

<br>
<br>
<br>
<br>
<br>
<br>

### 사각형 내 적 유닛 잡기

<br>
<br>

​워크래프트3 기본함수는 원형 범위만 제공됨

이로 인한 문제점은 

직선 장판기를 만들 때, 여러개의 원이 겹치는 형태로 잡으면 

원이 겹치는 구간이 생겨서 데미지 설계가 까다로움

그래서,

<br>
<br>

![7](https://github.com/user-attachments/assets/ebe65439-ec3d-45e0-8c79-41d36935f3d5) <br>

<img width="444" height="261" alt="스크린샷 2025-08-31 211818" src="https://github.com/user-attachments/assets/87ecb4cc-50f8-4012-9f62-1c991df2d665" />

사각형 범위 잡기를 이용하면

좀 더 일관적인 딜링을 하는 직선범위 장판스킬을 제작할 수 있음

<br>
<br>

<img width="319" height="396" alt="스크린샷 2025-08-31 212030" src="https://github.com/user-attachments/assets/28f297c6-2d19-4e9c-93ea-4f4ebeaf4ca0" />

CCW를 이용해서 다각형 내외 판별을 하였음

<br>
<br>
<br>
<br>
<br>
<br>

### 쉴드 시스템

<br>

![8](https://github.com/user-attachments/assets/69d43f96-ed73-42df-953f-1e3e5cbb93d9) <br>

![9](https://github.com/user-attachments/assets/8c26798f-0d43-441d-936b-ea60ef3cae86)

워크래프트에는 쉴드가 없음

그래서 스크립트를 이용하여 제작하였음

<br>

<img width="614" height="336" alt="스크린샷 2025-08-31 212516" src="https://github.com/user-attachments/assets/15239b65-ee65-4ed0-8cbf-98f8d67ac162" />

쉴드 구조체를 만들고, 해쉬테이블을 이용해서

유닛의 루트쉴드 참조하고, 

해당 루트 쉴드를 기반으로 쉴드 리스트 순회하면서 로직이 적용됨

<br>
<br>

이 시스템은 다음과 같음 장점이 있음

- 유닛 독립적

- 쉴드 중첩 지원

- 이펙트 지원 

- 쉴드량 표시 지원

- 쉴드 깨질꺼면 지속시간 제일 짧은 것 부터


<br>
<br>
<br>
<br>
<br>
<br>


### 인벤토리, 스탯, 랜덤아이템

<br>

![10](https://github.com/user-attachments/assets/3e834369-2f36-4b9d-9ec9-9885ddfec43b)

![11](https://github.com/user-attachments/assets/2ba44eb6-5701-42f8-a791-86922b2c5a1d)


일반 RPG 게임 같은,

스탯, 인벤토리 그리고 아이템을 구현하였음

해당 작업물은 <br>
외부파일 0개, 워크 오브젝트 0개 를 사용했기때문에 이식성이 높음, 코드만 복붙하면 바로 작동함

그리고 원신 같은 랜덤 스탯 랜덤 수치를 적용 하였음

<br>
<br>
<br>
<br>
<br>
<br>

### 인벤토리 예제 응용

<br>

위 인벤토리 예제를 활용하는 적당한 RPG 예제 맵을 제작 하였음

<br>
<br>
<br>

![12](https://github.com/user-attachments/assets/22de6844-754d-4fb6-bf30-963ff5c89931)

물리 데미지 폰트

물리 크리 데미지 폰트

평타에 공격력 반영

평타에 물리뎀증 반영

크리티컬 반영

​<br>
<br>
<br>

![13](https://github.com/user-attachments/assets/57603e49-2028-47f7-913c-7d1790c1143e)

마뎀

마법 데미지 폰트

마법 크리 데미지 폰트

마법 크리티컬

마법뎀증 

​<br>
<br>
<br>

![14](https://github.com/user-attachments/assets/b843c8fe-661f-49d1-a03b-dff9294b24ff)

상점에서 가상 아이템 구매

​<br>
<br>
<br>

![15](https://github.com/user-attachments/assets/085b7cf2-27cc-4dae-8ef9-e8f14f585fc3)

가상 스탯으로 공격속도 구현

​<br>
<br>
<br>

![16](https://github.com/user-attachments/assets/c8644403-e426-4a05-a281-79cf8ad04a03)


스킬에 공격속도 반영

스킬도 물리뎀증, 크리티컬 영향받음


