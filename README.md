# NewsBrief 📰

NewsBrief is a Flutter news application built using the BLoC state management pattern.
The app fetches real-time news articles using the NewsAPI and provides a reactive and clean user experience.

---

## ✨ Features

* View top headlines
* Search news articles
* Detailed news screen
* Bookmark articles
* Reactive UI using Flutter BLoC
* Loading, Success, and Error states
* Clean and scalable project structure

---

## 🧠 Tech Stack

* Flutter
* flutter_bloc
* Equatable
* HTTP
* NewsAPI

---

## 🌐 API Used

This project uses the NewsAPI service for fetching news data.

Get your API key from:
[NewsAPI Official Website](https://newsapi.org?utm_source=chatgpt.com)

---

## 📂 Project Structure

```text id="94x0w7"
news_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── services/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   ├── data/
│   │   ├── model/
│   │   └── repository/
│   │
│   ├── features/
│   │   ├── bookmarks/
│   │   ├── home/
│   │   ├── main/
│   │   ├── news_details/
│   │   ├── search/
│   │   └── splash/
│   │
│   └── main.dart
│
├── test/
├── README.md
└── secrets.env
```

---

## ⚙️ State Management

This project uses the BLoC architecture pattern for predictable and scalable state management.

Basic flow:

```text id="8ct2vh"
UI → Event → Bloc → State → UI
```

---

## 🔐 Environment Variables

Create a `secrets.env` file in the root directory and add your NewsAPI key.

```env id="f0aqji"
NEWS_API_KEY=your_api_key
```

---

## 🚀 Getting Started

### Clone the repository

```bash id="y8xgn5"
git clone <your-repository-url>
```

### Install dependencies

```bash id="1u9xzs"
flutter pub get
```

### Run the app

```bash id="y2p5r9"
flutter run
```

---

## 📸 Screenshots

Add your application screenshots here.

* Home Screen
* Search Screen
* News Details Screen
* Bookmark Screen

---

## 👨‍💻 Author

Built using Flutter and BLoC architecture for learning reactive state management and scalable application structure.
