/* Reflection
******************

Name : Tiago Linhares Villaca
Student Number: W20114785

Part A - Mark (9 /9)
-----------------------------

Comments - 1/1  - On multiple lines (e.g., 69,126,198, etc.) I tried to comment every part that I found it could help to undestand the code. 
indented/formatted - 1/1  -  Code follows clear structure.
naming - 1/1 -  Meaningful variable names like currentScreen, gameTitle,  timerIsSet, xdirection, ydirection, etc. 
inclusion of Readme - 1/1 - Present.
inclusion of completed Reflection - 5/5 - Present and Well documented and many samples of each section.


Part B - Mark (6 /6)
-----------------------------

Sizing 1/1 -  Defined at line 126 for outter screen (background) and at line 494 method "setInnerScreenSize" 
draw()  3/3 - line 195 and actively used. 
setup()  2/2 - line 124, initializes game settings.


Part C - Mark (10 /10)
-----------------------------
Use of if statements:
------------------------------------------
Please Have a look on these lines below
Line 297 to 362 - (game mode actions) a good amout of IFs statements like Nested IFs and Multiple conditions. 
-------------------------------------------
IF - Lines 144, 226, 249, 278 , 286 , 444, etc
Nested IF - Lines 297, 308, 312, 401 , 504, etc



Part D - Mark (20/20)
-----------------------------

Use of FOR statements -  Lines 246, 272
Use of Nested FOR statements - Lines 396, 438

Use of WHILE statements - 641, 672, 684 
Use of Nested While statements - Line 541


Part E - Mark (20/20)
-----------------------------

Use of Methods with NO parameters and Returns NO values
-----------
Method 1 - Line 136 - initialize()
Method 2 - Line 383 - showLevelSelection()
Method 3 - Line 233 - showMainScreen() 
and etc...

Use of Methods with A FEW parameters and Returns NO values
-----------
Method 1 - Line 463 - 1 Parameter - setLevel(int levelPicked)
Method 2 - Line 471 - 5 Parameters - placeTitles(String title, int  titleSize, int xPos, int yPos, color titlecolor)
Method 3 - Line 481 - 7 Parameters - placeButtons ( String ButtonLabel, int x, int y, int bWidth, int bHeight, int bRadius, color ButtonColor )
and etc...

Use of Methods with A FEW parameters and RETURN values
-----------
Method 1 - Line 501 - 1 Parameter and Returns INT value - int getXPaddlePosition(int playerAxisX)
Method 2 - Line 600 - 2 Parameters and Returns an array of INT - int[] bounceTitles (int x, int y)
Method 3 - Line 717 - 4 Parameters and Returns BOOLEAN value - boolean overButtons(int x, int y, int width, int height)


Part F - Mark (10/10)
-----------------------------
Use of Processing function:
---------
1- rectMode(CENTER) - Line 130
2- colorMode(HSB, 27 ) - Lines 264, 267 
3- translate(500, 400) - Libe 348
4- rotate(radians(angleRotate)) - Line 349
5- ellipse() - Lines 392 , 431 , 242 etc
6- rect() - Lines 373, 488, 497
7- color() - from 175 to 182
8- abs() - Lines 315, 719
9- constrain() - Lines 304, 305
and etc.... many others

Part G - Mark (10/10)
-----------------------------
Use of mouse functions:
-----------

Method 1 - void mouseReleased() - Line 634
Method 2 - void mousePressed() - Line 705

Use of mouse Buttons - Lines 686, 689, 708, 710 
Use of mouse Coordenates - Lines 719, 372, 504, 506 


Part H - Mark (10/10)
-----------------------------
Use of string Functions:
---------------
1- trim() - Line 287
2- toLowerCase() - Line 288
3- substring(0, 1) - Lines 289, 291
4- toUpperCase() - Line 290
5- length() - Line 291
6- replace() - Lines 251, 254



Part I - Mark (4/5)
-----------------------------
Pros
  Game mechanics well implemented with strong structure.
  Good flow when switching between screens. 
  Game Mode/Level selection are properly working. 
  Functions to facilitate finding and fixing bugs are implemented. 
  Game is enjoyable. 

Cons
  Only one bug (Known) might remains appearing at times. ( see ReadMe -> Bugs/prblems -> number 4 )


Overall mark (99/100)
-----------------------------
A = 9/9
B = 6/6
C = 10/10
D = 20/20
E = 20/20
F = 10/10
G = 10/10
H = 10/10
I = 4/5

Summing : 9+6+10+20+20+10+10+10+4=  99

*/
