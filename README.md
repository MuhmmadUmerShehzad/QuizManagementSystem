# Quiz Management System

A robust, web-based Quiz Management System developed using **ASP.NET Core Blazor** and **SQL Server**. The application features Role-Based Access Control (RBAC) to provide tailored experiences for Administrators, Teachers, and Students. It streamlines the process of creating, managing, and taking quizzes, with comprehensive features for randomized assessments, timed tests, and automatic result tracking.

## Features

### Role-Based Access Control (RBAC)
- **Admin**: Manages the overall system, oversees users (Teachers and Students), and monitors system activity through a dedicated Admin Dashboard.
- **Teacher**: 
  - Accesses the Teacher Dashboard.
  - Manages questions (CRUD operations) and categorizes them by subjects.
  - Creates and configures quizzes (sets duration, randomization, shuffle options, max attempts).
  - Assigns specific questions to quizzes.
  - Monitors student quiz attempts and results.
- **Student**: 
  - Accesses the Student Dashboard.
  - Views available quizzes.
  - Attempts timed quizzes.
  - Views immediate results and historical performance.

### Core Functionalities
- **Question Bank**: Centralized repository for questions, including support for difficulty levels and image URLs.
- **Quiz Configuration**: Highly customizable quizzes allowing for randomized question order and shuffled options.
- **Attempt Tracking**: Detailed tracking of student attempts, selected answers, start/end times, and calculated scores.
- **Notifications**: System alerts and notifications for users.

## Technologies Used
- **Frontend**: ASP.NET Core Blazor (Interactive Server), HTML, CSS, Bootstrap
- **Backend**: C#, ASP.NET Core
- **Database**: Microsoft SQL Server
- **ORM**: Entity Framework Core

## Prerequisites
- [.NET SDK](https://dotnet.microsoft.com/download) (Compatible with your project version)
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (Express or Developer Edition)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) or Visual Studio Code

## Getting Started

Follow these steps to set up the project locally:

### 1. Clone the Repository
```bash
git clone https://github.com/MuhmmadUmerShehzad/QuizManagementSystem.git
cd QuizManagementSystem
```

### 2. Database Setup
A SQL script is provided to create the necessary database schema.
1. Open SQL Server Management Studio (SSMS) or Azure Data Studio.
2. Connect to your local SQL Server instance.
3. Open the `quizSQL.sql` file located in the root directory.
4. Execute the script. It will create a database named `QuizDB` along with all required tables (`Users`, `Subjects`, `Questions`, `Options`, `Quizzes`, `Attempts`, `Answers`, `Results`, `Notifications`).

### 3. Update Connection String
Update the database connection string in the `QuizManagementApp/appsettings.json` file to match your SQL Server instance:

```json
"ConnectionStrings": {
  "DefaultConnection": "Server=YOUR_SERVER_NAME;Database=QuizDB;Trusted_Connection=True;TrustServerCertificate=True"
}
```
*(Note: Replace `YOUR_SERVER_NAME` with your actual SQL Server instance name, e.g., `DESKTOP-XXXX\\SQLEXPRESS`)*

### 4. Run the Application
Navigate to the project directory and run the application:

```bash
cd QuizManagementApp
dotnet run
```
Alternatively, you can open the `QuizManagementApp.slnx` or `QuizManagementApp.csproj` file in Visual Studio and run the project directly using IIS Express or Kestrel.

## Project Structure
- `QuizManagementApp/`: Main Blazor application project directory.
  - `Components/Pages/`: Contains Blazor UI components for Dashboards, Login, and various Quiz management interfaces.
  - `Components/Models/`: Contains the C# entity models mapping to the database schema.
  - `Components/Data/`: Contains the `AppDbContext` for Entity Framework Core configurations.
- `quizSQL.sql`: The raw SQL script to quickly scaffold the database schema.

---
*This project was developed as part of an academic lab exercise (Lab 08).*