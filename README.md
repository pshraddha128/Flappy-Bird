# Flappy-Bird
This repository contains the source code for a Flappy Bird game implemented in Lua using the Love2D framework. The game follows the classic Flappy Bird mechanics, where the player controls a bird to navigate through pipes and score points.
## Prerequisites
Love2D must be installed to run the game. Follow the Love2D installation instructions for your operating system.
## Overview
### File Structure
- main.lua: The entry point of the application, includes game setup, initialization, and the Love2D main loop.
- Bird.lua: Defines the Bird class with methods for bird movement and rendering.
- Pipe.lua: Implements the Pipe class responsible for creating individual pipes.
- PipePair.lua: Manages pairs of pipes, controlling their generation and movement.
- StateMachine.lua: Implements a basic state machine to handle different game states (title screen, play, score, countdown).
- states/: Contains Lua files defining different game states used by the state machine.
- background.png: Image file for the game background.
- ground.png: Image file for the ground.
- font.ttf: Font file for text rendering.
- flappy.ttf: Font file for the Flappy Bird title.
- sounds/: Directory containing sound files used in the game.
### Game Flow
- Title Screen: The game starts with a title screen where the player can initiate the game.
- Play State: The main gameplay state where the player controls the bird to navigate through pipes.
- Score State: Displays the player's score after the game ends.
- Countdown State: Provides a countdown before the game begins.
### Controls
Spacebar: Make the bird jump.
### Features
- Scrolling Background: The game features a scrolling background to create a sense of movement.
- Pipe Generation: Pipes are randomly generated, creating new challenges for the player.
- Score Tracking: The game keeps track of the player's score.
- Sound Effects and Music: Various sound effects and background music enhance the gaming experience.
