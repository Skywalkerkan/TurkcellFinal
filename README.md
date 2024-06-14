
<div align="center">
  <h1>Dictionary App - Turkcell Final HW by Erkan Coşar</h1>
</div>

This app is a dictionary library clone. In short, it is a dictionary library application. You can find a English word you desire

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [In App](#In-App)
- [Known Issues](#known-issues)
- [Improvements](#Improvements)

## Features

 **See All Of The Words Meaning:**
- Easily follow the word'' meaning and part of speech from the dictionary app thanks to Handy Dictionary.
- The API used is https://api.dictionaryapi.dev/api/v2/entries/en/{word},  https://api.datamuse.com/words?rel_syn={word} 
  
 **Add Favorites Your Game:**
- Enjoy your time with the games you see in your library.
- Data is saved locally with the help of Coredata by user's adding favorite.
 ## Screenshots

| Image 1                | Image 2                | Image 3                |
|------------------------|------------------------|------------------------|
| ![1](https://github.com/Skywalkerkan/MovieApp/assets/117943189/224979df-d2ca-46ae-b6b2-c45c6f63da78)| ![2](https://github.com/Skywalkerkan/MovieApp/assets/117943189/04ecb1cf-1c28-4bee-a366-eb7881ead5a0)| ![3](https://github.com/Skywalkerkan/MovieApp/assets/117943189/f598d9ba-a793-49cc-ae94-42eb84b2fd3d)|

| Image 4                | Image 5                | Image 6                |
|------------------------|------------------------|------------------------|
| ![4](https://github.com/Skywalkerkan/MovieApp/assets/117943189/8a2e6353-046a-4bcf-aab6-c5fc89b8f492)| ![5](https://github.com/Skywalkerkan/MovieApp/assets/117943189/6bb73d21-21cb-4060-b37f-a57ced890050)| ![6](https://github.com/Skywalkerkan/MovieApp/assets/117943189/59827d5f-c4a2-4525-9d6f-9a1f47bb8dd8) |


## Tech Stack
- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 13.0


## Architecture
![Viper](https://github.com/Skywalkerkan/MovieApp/assets/117943189/2ddfdd15-82fb-4214-9e1b-077f9e9637b1)

VIPER is an architectural pattern widely used in iOS app development to organize application modules in a logical manner and reduce dependencies between them.

VIPER consists of five main components:
- View: Represents the user interface and detects user interactions.
- Interactor: Executes the business logic of the application and manages data.
- Presenter: Prepares and formats data to be presented by the View.
- Entity: Represents data models.
- Router: Handles navigation between modules.
VIPER promotes a structure where each component has a specific responsibility and communicates tightly with others. This approach helps in building modular and manageable codebases, even for large-scale projects.

## In App
- Viper Architecture
- Protocol Oriented
- Core Data
- Unit UI Testing
- Modular Programming

## Known Issues
- None

## Improvements
- New features can be added to main pages and details
- Dictionary Details can be improved by more ui
