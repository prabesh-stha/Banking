# Banking Application

A **secure** and **scalable** mobile banking application built with **SwiftUI** and **Firebase**, designed to provide seamless banking experiences.

## Features

- **User Authentication** (Face ID, Email & Password)
- **Account Management** (Create, View, and Manage Accounts)
- **Transaction History** (View Past Transactions)
- **Fund Transfers** (Send Money Securely)
- **Real-time Data Syncing** (Using Firebase NoSQL)
- **Modern UI with SwiftUI**

## Tech Stack

- **SwiftUI** (UI)
- **Firebase** (Authentication, Firestore NoSQL, Storage)
- **Combine** (Reactive Programming)
- **MVVM Architecture** (Separation of Concerns)

## 📲 Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/prabesh-stha/Banking.git
   cd Banking
   ```

2. Install dependencies using **Swift Package Manager (SPM)**.

3. Set up Firebase:
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/)
   - Download `GoogleService-Info.plist` and place it in the project root.

4. Run the app:
   ```sh
   Xcode -> Run (Cmd + R)
   ```

## Project Structure

```
📂 BankingApp
│── 📂 Models
│── 📂 ViewModels
│── 📂 Views
│── 📂 Managers
```

- **Models** – Data structures (User, Account, Transaction, etc.)
- **ViewModels** – Handles business logic using MVVM.
- **Views** – SwiftUI UI components.
- **Managers** – Handles different Firestore collections.


