# 🏡 Airbnb Flutter Clone

Một bản sao ứng dụng Airbnb được xây dựng bằng Flutter với kiến trúc Clean Architecture, nhằm rèn luyện kỹ năng xây ứng dụng thực tế, quản lý state hiệu quả và tối ưu trải nghiệm người dùng với giao diện dạng modal.  
Dự án được thực hiện như bài tập cuối khóa tại **Cybersoft Academy**.

🎥 **Xem video demo tại đây**: [YouTube Demo](https://youtu.be/T1Am5HTy0eQ)

---

## ✅ Tính năng chính

- ✅ **Đăng nhập / Đăng ký**
- ✅ **Giữ đăng nhập qua token**
- ✅ **Khám phá phòng theo vị trí**
- ✅ **Xem chi tiết phòng**
- ✅ **Đặt phòng**
- ✅ **Viết đánh giá sau chuyến đi**
- ✅ **Danh sách phòng yêu thích**
- ✅ **Chỉnh sửa hồ sơ**
- ✅ **Upload avatar**
- ✅ **Tìm kiếm phòng nâng cao**
- ✅ **Giao diện dạng modal toàn phần**

---

## 🎓 Kỹ năng & Kiến thức đạt được

- Áp dụng **Clean Architecture** để phân tách rõ ràng giữa UI, logic nghiệp vụ và dữ liệu
- Sử dụng **Riverpod** để quản lý state theo từng feature độc lập
- Kết nối và xử lý dữ liệu từ **RESTful API** với thư viện **Dio**
- Tích hợp **JWT** để xử lý xác thực và phân quyền
- Lưu trữ token và dữ liệu yêu thích với **Flutter Secure Storage** và **Hive**
- Xây dựng giao diện người dùng linh hoạt, hiện đại với **modal_bottom_sheet**
- Tối ưu khả năng mở rộng và bảo trì mã nguồn

---

## 🧱 Kiến trúc dự án

Dự án tuân theo mô hình **Clean Architecture** để tách biệt từng lớp chức năng:

<details>
<summary>📁 Cấu trúc thư mục <code>lib/</code></summary>

```plaintext
lib/
├── core/                 # Thành phần dùng chung (api_client, storage, utils...)
├── features/             # Các tính năng chính
│   ├── auth/             # Đăng nhập, đăng ký
│   ├── explore/          # Khám phá phòng
│   ├── room_detail/      # Chi tiết phòng
│   ├── booking/          # Đặt phòng
│   ├── review/           # Viết đánh giá
│   ├── favorites/        # Yêu thích phòng
│   ├── profile_reactive/ # Hồ sơ người dùng
│   └── edit_profile/     # Chỉnh sửa hồ sơ
├── providers/            # Các provider toàn cục (tokenCheck, tabIndex, v.v.)
└── shared/
    ├── layouts/          # Layouts dùng chung
    ├── widgets/          # Widget tái sử dụng
    └── modals/           # Quản lý hệ thống modal
```

</details>

---

## 🛠️ Công nghệ sử dụng

- **Flutter 3.x**
- **Riverpod** – State Management hiệu quả, rõ ràng
- **Dio** – HTTP Client mạnh mẽ cho API RESTful
- **modal_bottom_sheet** – Giao diện dạng modal như Airbnb
- **Flutter Secure Storage** – Lưu token JWT an toàn
- **Hive** – Local Storage cho danh sách yêu thích
- **Intl** – Định dạng ngày giờ, tiền tệ
- **GoRouter** – Quản lý định tuyến cho Splash, MainLayout

---

## 🌐 Cấu hình API

- **Base URL**: `https://airbnbnew.cybersoft.edu.vn/api/`
- **Header mặc định**:
  - `tokenCybersoft`: Token hệ thống (gắn sẵn trong `ApiClient`)
  - `Authorization`: `Bearer <token>` – token người dùng sau khi đăng nhập

---

## ⚙️ Cài đặt & Chạy ứng dụng

```bash
git https://github.com/vinh4979/flutter_clone_airbnb.git
cd airbnb_flutter_clone
flutter pub get
flutter run
```

> ⚠️ Bạn cần **Flutter SDK 3.x** trở lên. Đảm bảo đã cấu hình đầy đủ môi trường Flutter để chạy được ứng dụng.

---

## 🧑‍💻 Tác giả

- **Họ tên**: Bui Vinh
- **Vai trò**: Flutter Developer
- **Học viên tại**: [Cybersoft Academy](https://cybersoft.edu.vn)
- **Mục tiêu**: Xây dựng ứng dụng sạch, hiện đại và có khả năng mở rộng lâu dài.

---
