
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
  


 ## Screenshots

| Image 1                | Image 2                | Image 3                |
|------------------------|------------------------|------------------------|
| ![1](https://github.com/user-attachments/assets/21cdcd23-4c4d-4f0b-a1bd-91ab7c2827df)| ![2](https://github.com/user-attachments/assets/fa071264-d9d8-4448-bfc1-a54e29a079c1)| ![3](https://github.com/user-attachments/assets/34df4ea0-6dd9-4b97-a6f3-1fcc7d65f804)|

| Image 4                | Image 5                | Image 6                |
|------------------------|------------------------|------------------------|
| ![4](https://github.com/user-attachments/assets/b95740b9-8fca-4195-80d4-ba83d5b2d407)| ![5](https://github.com/user-attachments/assets/bd5267be-3f57-4078-8059-d75c9414734d)| ![6](https://github.com/user-attachments/assets/ea027d10-e4ba-482e-98d0-ff72b16a9520)|


## Tech Stack
- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 13.0


## Architecture
![viper](https://github.com/user-attachments/assets/8b06133d-38d0-43e2-94c1-2cd9ab1b1fb9)

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
