/*

Name : Tiago Linhares Villaca
Student Number: W20114785

Brief description of piece (1 or 2 sentences MAX):
===================================================
Game created to be submited as an assignment for programming subject in feb-2025.
It is a Bouncing Ball game. Keep the ball up to win ! 


Instructions:
=============

1 -Main Screen - Select one of the 3 options "Start" , "Level" , "Setting"
***************************
1.1--- "Start" - Start the game on Level 1 if a level is not set by the player.
1.1.1------ Games is on ! Pay attention to the countdown and play.
***************************
1.2--- "Level" - if you feel confident, you can select an advanced level
1.2.1------ Select a level between 1 to 12. Press "Restart" to return to main screen
******************************
1.3--- "Setting" - Change a few configurations and some debug modes
Press mouse LEFT button to enable function and mouse RIGHT Button to disable function 
1.3.1------ "Show parameter:" - Debug mode to see some hidden variables and help to fix up bugs 
1.3.2------ "No Game Over:" - Debug mode. Increse the paddle size to maximum then you can see the flow and changes from level 1 to 12.
1.3.3------ "Pause Function" - Allows you to pause the game and resume as you want. it ONLY works on GAME SCREEN. 
Press Mouse MIDDLE Button to pause, and again to resume the game. 
1.3.4------ "Double paddle size" - If you dont feel confident. you can double the paddle size to ease the game and pratice more. 

Known bugs/problems/References:
================================
References:
==============

1 - Constrain Example at 
https://processing.org/examples/constrain.html
Used to understand how to constrain an object into a screen.

2 - Bounce Example at 
https://processing.org/examples/bounce.html
used to understand how to bounce an object, give it a coordanates, speed, direction. 

3- Buttons at
https://processing.org/examples/button.html
used to understando how to create buttons on screen, make it chance colors and identify when it is pressed or the pointer is over the button. 

4- Switch Statements at
https://processing.org/reference/switch.html
used to control the flow between screen and button functions. 
5- Color Picker at 
https://imagecolorpicker.com/color-code/2596be
Get RGB values for the desired color. 

6- Hue at
https://processing.org/examples/hue.html
https://processing.org/tutorials/color
used to understand to vary color in a certain spectrum. In this case, it will be varying from level 1 ( minimum speed) to level 12 ( maximum speed).

7- Rotation at
https://processing.org/examples/textrotation.html
used to understand how to rotate an object. Game Over message was set with rotation.

8- Line General Equation at
https://www.mathcentre.ac.uk/resources/uploaded/mc-ty-strtlines-2009-1.pdf
used to understand how to generate an equation of a straight line which will be used as direction of the ball

Bugs/problems:
================

1- Line general Equation - 
  Inially, I thought I could develop the line general equation by myself. It was not working as expected. then I found that (2 - Baouce Ball )reference . 
  To Be honest, I could not understand properly the way the (x,y)is calculated. speed and direction is easy to understand.  see bellow.
  
  "Bounce Ball example" uses 2 equations to calculate the coordenates.
    xBallPos = xBallPos + ( xspeed * xdirection );
    yBallPos = yBallPos + ( yspeed * ydirection );
  
  I woul calculate like this one:
  Y = mX +b ; 
  
  I am not able yet to formulate a thought to reach that conclusion by myself, but I am on the way to get there.
  
2- SWITCH as opposite to IF/ELSE statements.
IF/ELSE was dodgy/tricky to do this. SWITCH jump straight to point. IF/ELSE needs to check each statement everytime.
The flow were not good, screen were not flickering properly with IF/ELSE.

3- Level selection - Bug fixed - line 145 
Level selected by the player was being lost and reset when flickering between screen. or not being reset when it is game over. 
An IF statement was created to set when the level should be reset or not. 

4- Ball trembles and glue at the walls of inner screen - Potencially fixed. it could happen to the titles as well. 
the equation was generating (x , y) values beyond the limits and it was getting buggy when the balls reaches the corners,it could glue and keep trembles up and down.
I corrected the boundaries using "constrain()" and adjusting the IF conditions.  
I have not seen it for a while, but not 100% sure it is fixed. 

5- Use of Str () - This function was not allowed. I have used this one in many places to convert INTs into Strings and show them on screen.  
I talked to Siobhan and She gave me a suggestion of how to get rid of str().
I corrected my code and it worked perfectly fine. 

Future Improvements:
=====================
1- Colors Pallete 
I would spend more time lerning about color pallete, and give it a better look, something more smoth and nicer to look at. 

2- Full screen mode
I would redo parts of the code to link everything to width and height, to set up a full screen mode. 
I think it could be tricky and time consuming to fix bugs and to reposition all the items. I decided to leave it as it is. 

3- Challenges and hazards
I would implement some challenges and hazard along the game, to make it more fun. 

4- Saving historical data of players 
I would like to create a historical data and save it to keep records about who is playing and create a top 10 scoreboard.

*/
