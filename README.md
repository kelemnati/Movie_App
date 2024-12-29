# Movie App 🎥

A **Flutter Movie App** that integrates with **TMDB API** for fetching movie data and **Firebase Authentication** for user management. Users can browse movies by genre, popularity, trending, and top-rated, and like movies to maintain a personalized list.

---

## Features

### Movie Features

- Browse movies:
  - By Genre
  - Popular Movies
  - Trending Movies
  - Top-Rated Movies
- View detailed movie information: Poster, Title, Overview, Release Date, Rating, Genres, etc.
- Like movies and save to the user's personalized list.

### User Features

- Sign Up: Register with email, password, and username.
- Sign In: Authenticate with email and password.
- Maintain a list of liked movies in Firebase.
- Sign Out securely.

---

## Folder Structure

```
lib/
├── Data/
│   ├── model/
│   │   ├── movie_model.dart      # Defines movie data structure
│   │   ├── user_model.dart       # Defines user data structure
│   ├── data_provider/
│   │   ├── user_data_provider.dart # Firebase interaction for user management
│   │   ├── movie_service.dart      # API interaction with TMDB
│   ├── repository/
│       ├── user_repository.dart    # Handles user-related operations
│       ├── movie_repository.dart   # Handles movie-related operations
├── blocs/
│   ├── authentication/            # Bloc for user authentication
│   ├── user_feature/               # Bloc for user-related features
│   ├── movie_feature/              # Bloc for movie-related features
│   ├── theme/                      # Bloc for light/dark mode
├── presentation/
│   ├── screens/
│   │   ├── home_screen.dart       # Home screen
│   │   ├── search_screen.dart     # Search screen with shimmer effect
│   │   ├── profile_screen.dart    # Profile screen
│   ├── widgets/                   # Common widgets
├── config/
│   ├── themes/                    # Theme configurations
│   ├── app_routes.dart            # App navigation routes

---

## API Integration with TMDB

### Key Endpoints:

1. **Popular Movies**:
```

https://api.themoviedb.org/3/discover/movie?api_key={API_KEY}&sort_by=popularity.desc

```
2. **Movies by Genre**:
```

https://api.themoviedb.org/3/discover/movie?api_key={API_KEY}&with_genres={genre_id}

```
3. **Trending Movies**:
```

https://api.themoviedb.org/3/trending/movie/{time_window}?api_key={API_KEY}

```
4. **Top-Rated Movies**:
```

https://api.themoviedb.org/3/movie/top_rated?api_key={API_KEY}

````

---

## Firebase Integration

### User Features

1. **Sign Up and Sign In**:
- Firebase Authentication for user management.
2. **Liked Movies**:
- Store liked movie IDs in Firestore in the `likedMovies` array field.

### Firestore Rules

```firestore
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
 match /users/{userId} {
   allow read, write: if request.auth != null && request.auth.uid == userId;
 }
}
}
````

---

## How to Run

### Prerequisites

- Flutter SDK installed.
- Firebase configured for your project.
- TMDB API Key.

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/movie-app.git
   cd movie-app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Add `.env` file with your API key:
   ```plaintext
   TMDB_API_KEY=your_tmdb_api_key
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## Future Enhancements

- Add movie search functionality.
- Support for a watchlist feature.
- User profile customization.

---
