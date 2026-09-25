# CAVT Smart Admissions

A smart admissions and branch administration system built with Flutter and Supabase for the College of Advanced Vocational Training (CAVT).

## Features

### Student Portal
- Account registration and secure sign-in
- Browse training programs
- Select a CAVT branch
- Submit admission applications
- Upload supporting documents
- Track application status and history
- Arabic and English interface
- Light and dark themes

### Administration Portal
- Separate administration login
- Branch-based access control
- Multiple administrator accounts per branch
- View only applications assigned to the administrator's branch
- Search and filter applications
- Review applicant data and uploaded documents
- Update application status
- Add reviewer notes
- View status history
- Secure logout

## Supported Branches
- Hakama
- Irbid - Female
- Yajouz
- Sahab
- Ain Al-Basha
- Ghor Al-Safi
- Aqaba

## Technology Stack
- Flutter
- Dart
- Supabase
- PostgreSQL
- Supabase Authentication
- Supabase Storage
- Row Level Security (RLS)
- Git & GitHub

## Backend and Security
The backend includes profiles, branches, programs, applications, application documents, and status history.

Security includes:
- Authentication
- Role-based access
- Branch-based authorization
- PostgreSQL Row Level Security
- Private document storage policies
- Restricted profile updates

Administrator credentials and private backup files are not stored in this repository.

## Workflow
1. A student creates an account and signs in.
2. The student selects a program and branch.
3. The student submits an application and documents.
4. The application becomes available only to administrators assigned to that branch.
5. An administrator reviews the application and updates its status.
6. The student tracks the updated status from the student portal.

## Current Status
Implemented and tested:
- Authentication
- Application submission
- Document upload
- Application tracking
- Status history
- Branch-specific administration
- Multiple administrator accounts per branch
- Row Level Security enforcement

Next improvements:
- Code refactoring and folder structure
- State management
- Automated testing
- UI polish
- Deployment preparation

## Local Setup
1. Install Flutter.
2. Clone this repository.
3. Run `flutter pub get`.
4. Configure your own Supabase project URL and publishable key.
5. Run `flutter run`.

## Disclaimer
This is a portfolio and development project demonstrating an admissions workflow and branch-based administration system. It does not contain production administrator credentials or private user data.
