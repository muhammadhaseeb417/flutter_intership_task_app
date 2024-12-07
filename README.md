# Flutter Internship Task App

This Flutter application is built as part of the internship task. The task involves implementing authentication screens (Login, Signup, OTP Verification) with proper API calls, using the MVVM architecture, and incorporating GoRouter for routing. Due to a time constraint, state management using Riverpod was not implemented, but the rest of the features were fully implemented as per the given requirements.

## Features Implemented
1. **Login Screen**: UI built and connected to the login API using the provided endpoint.
2. **Signup Screen**: UI created and connected to the signup API.
3. **OTP Verification Screen**: OTP input UI with connection to a simulated OTP verification API.
4. **Dashboard Screen**: Basic UI for the dashboard as per the design provided.
5. **Routing**: Implemented routing using GoRouter for navigation between screens.
6. **Reusable Widgets**: Common UI components like buttons, text fields, and error messages are abstracted into reusable widgets.

## Technologies Used
- **Flutter**: For building the mobile app.
- **MVVM Architecture**: To separate concerns and enhance testability and maintainability.
- **GoRouter**: For routing and navigation.
- **API Integration**: Simulated APIs for login, signup, and OTP verification.

## API Details
- **Login API**:
  - Endpoint: `GET https://jsonplaceholder.typicode.com/users?email={email}`
  - Simulates login by checking the provided email.
  
- **Signup API**:
  - Endpoint: `POST https://jsonplaceholder.typicode.com/users`
  - Simulates user registration by sending a JSON body with user details.

    Example request body:
    ```json
    {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "password": "password123"
    }
    ```

- **OTP Verification API**:
  - Simulated by using the same `POST` endpoint, adding an OTP field for verification.

## Getting Started

To run this project locally, follow these steps:

### 1. Clone the repository
```bash
git clone <repository-url>
cd flutter_intership_task_app
