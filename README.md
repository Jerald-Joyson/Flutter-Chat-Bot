# Flutter Chat Bot with GetX

This Flutter project is a chat application integrated with Google Gemini API, using GetX for state management. It supports session-based chat history, allowing users to start new chat sessions, rename, and delete existing sessions. 

## Features

- Chat with Google Gemini AI
- Session-based chat history
- Start new chat sessions
- Rename and delete existing sessions
- Responsive UI

## Installation

1. **Clone the repository:**

```bash
   git clone https://github.com/Jerald-Joyson/Flutter-Chat-Bot.git

   cd Flutter-Chat-Bot
```

2. **Install dependencies:**

```bash
   flutter pub get
```

3. **Run the app:**

```bash
   flutter run
```

## Usage
1. **Start a new chat session:** Click the + button in the AppBar or in the Session Drawer.
2. **View session history:** Open the drawer by clicking the leading button in the AppBar.
3. **Rename a session:** Click the edit icon next to the session in the drawer.
4. **Delete a session:** Click the delete icon next to the session in the drawer.

## Project Structure

```
    lib
    │
    ├── controller
    │   └── chat_controller.dart
    │
    ├── model
    │   └── chat_message.dart
    │
    ├── view
    │   ├── chat_screen.dart
    │   ├── session_drawer.dart
    │   └── chat_bubble.dart
    │
    └── main.dart
```
## Dependencies

- GetX
- Get Storage
- Google Gemini AI

## Contributing

1. Fork the repository
2. Create your feature branch (git checkout -b feature/my-feature)
3. Commit your changes (git commit -m 'Add my feature')
4. Push to the branch (git push origin feature/my-feature)
5. Open a pull request

## Acknowledgments
GetX for state management
Google Gemini AI for the AI chat functionality
Flutter for the framework

## Screenshots

<!-- ![Screenshot 1](screenshots/screenshot1.png)
![Screenshot 2](screenshots/screenshot2.png) -->