/**
 * Bouncing Ball
 *
 * Use the paddle to hit the ball up and keep playing.
 * When the ball hits the edge of the inner screen, it reverses its direction.
 *
 */
import javax.swing.*;  // for dialog messages

// Student details ***************************************************************************************
final String studentName = "Tiago Linhares Villaca";
final String studentID = "W20114785";

//Paddle Variables **********************************************************************************
int xPaddlePos, yPaddlePos ;                                        // x and y Paddle Position
int wPaddleSize = 200, hPaddleSize = 20 ;                           // Width and height Paddle Size
int wPaddleDefault=200, wPaddleDouble=400, wPaddleNoGameOver=850;   // Functions Double and No game Over

//Ball Variables**************************************************************************************
int rad = 10;                   // Ball width
float xBallPos, yBallPos;       // Ball Starting position

float xspeed = 3, yspeed = 3;   // Ball Speed

float minSpeed = 3;            // speed for level 1
float maxSpeed = 27;           // speed for level 12

float speedRate = 0.25 ;       // Speed rate increase
float levelRange = (maxSpeed-minSpeed)/12;  // Level range

int xdirection = 1;           //  (-1)Left or (1) Right
int ydirection = 1;           //  (-1)Up   or (1) Down

// Inner Screen Size Variables*******************************************************************************
int edge = 50;            // Edge
int inner = edge + rad;   // Edge + Ball Radious

// Game Mode Screen **********************************************************************************

//Scoreboard
int score, level=1;                           // hold scoreboard values
String playerName;                            // hold player name
Boolean playerNameStatus ;                    // True if player name is set.
int [] xScoreBoard = { 225, 500, 775 };        // x Position of Scoreboard items
int yScoreBoard = 80 ;                         // y Position of Scoreboard items
int [] sizeScoreBoard = { 250, 30, 10 };      // { Width , Height, Radius corners } Size of Scoreboard items
String [] scoreBoardLabel = {"Name: ", "Score: ", "Level: "};  // label of Scoreboard items
color scoreboardColor;                        // color of scoreboard

//Game over
boolean gameOver=false ;   // true when the match is finished.
String gameOverStr = "Game Over !!!";   // Game over message
float angleRotate;                      // Game over angle of rotation

//Timer
int timerSecInFrames;                 //  hold a (x) seconds in number of frames
boolean timerIsSet;                   // true if the timer is set
int [] countDownParam = {500, 500, 100, 100, 2 };  // {x , y, width , heigth, radius}
color countDown;                       // default color of the shape

// Main screen  **********************************************************************************
//General
String currentScreen;                  //  hold the current screen being shown.
String mainScreen = "mainScreen";      // ID to call up main screen
color defaultScreenColor, notPressedButtonColor, pressedButtonColor;  // default colors for screen and buttons
int frameRateDef = 60;                // default frame rate

//Buttons
int [] xInitialButtons = { 300, 500, 700 };      // x Position of main screen buttons
int yInitialButtons = 400 ;                      // y Position of main screen buttons
int [] sizeStartButtons = { 150, 60, 10 };       // { Width , Height, Radius corners } Size of main screen buttons
Boolean [] ButtonOverP1 = {false, false, false};  // true when the pointer is over its respective button

//Titles
String [] buttonsLabel = {"Start", "Level: <L>", "Settings"};      // Screen titles and button labels
String Levelplace = "<L>";                                         // Placeholder of the current Level of the game
final int startButton=0, levelButton=1, settingsButton=2;         //  index of String buttonsLabel
int titleBallrad = 60;

String gameTitle = "Bouncing Ball";                          // Game Title
int [] xyBounceTitles = new int[2];                          // x and y position for the bouncing titles
color defaultTitleColor;                                     // color fo the title
int  defaultTitleSize;                                       // size of the title

// Level screen buttons Variables **********************************************************************************
int [] xLevelButtons = { 200, 400, 600, 800 };       // x Position of level buttons
int [] yLevelButtons = { 220, 400, 600 };            // y Position of level buttons
int [] sizeLevelButtons = { 150, 60, 10 };           // { Width , Height, Radius corners } Size of level buttons
Boolean [] levelButtonOver = {false, false, false, false, false, false, false, false, false, false, false, false};  // true when the pointer is over its respective button

// Restart Button **********************************************************************************
int xRestartButton, yRestartButton, wRestartButton, hRestartButton, rRestartButton;// {x , y, Width , Height, Radius corners }  Position and size of Restart button
int xRestartButton2, yRestartButton2;           // x , y for level page
final String restartButtonStr = "Restart";      //Label of restart button
Boolean restartButtonOver = false;               // true when the pointer is over the restart button

// Settings **********************************************************************************
int [] xSettingsButtons = { 300, 700 };                      // x Position of settings buttons
int [] ySettingsButtons = { 300, 500 };                      // y Position of settings buttons
int [] sizeSettingsButtons = { 350, 40, 10 };                // { Width , Height, Radius corners } Size of settings buttons
String [] SettingsLabel = {"Show Parameters: ", "No Game Over Mode: ", "Pause Function: ", " Double Paddle Size: "};    // Label of the settings buttons
final int showParam=0, noGameOver=1, Pause=2, DoublePaddleSize=3 ; // index of [] SettingsLabel
Boolean [] SettingsButtonOver = {false, false, false, false}; // true when the pointer is over its respective button
boolean [] ActiveSettings = {false, false, false, false}; // true when the function is ON {"Show Parameters: ", "No Game Over Mode: ", "Pause Function: ", "Paddle Size: "}
color settingsOn, settingsOff; // Default colors

//Pause function
boolean pauseGame=false;                                 // True when the Pause game is ON
String pauseMessage = "Press mouse middle button to resume!";
int [] pauseParam = {500, 500, 450, 40, 2 };            // {x , y, width , heigth, radius} Position and size of pause button in main screen

//Instructions
String mainInstructions = " Press mouse LEFT button to enable \n Press mouse RIGHT button to disable ";
String [] BInstructions = { " Hidden properties are shown on \n the screen to facilitate debugging.",
  " The paddle size is increased to \nthe maximum value to allow us \n to see the changes on screen until level 12. ",
  " Press mouse CENTER button to pause the game. \n Only when the game screen is running. ",
  " Double the paddle size to ease the game. "};     // Paddle Size

//Position of the parameters shown
int [] xParameters = { 200, 400, 600, 800 };  // Columns for the parameters list
int yParameters = 15;                         // number of items per column

// SETUP **********************************************************************************************
void setup()
{
  size(1000, 800);             // Main Screen size
  noStroke();
  frameRate(frameRateDef);
  ellipseMode(RADIUS);        // Set how ellipses will be drawn
  rectMode(CENTER);           // Set how rectangles will be drawn

  initialize();              // initialize game variables
}

// Default values for variables
void initialize()
{
  // Set the starting Ball Position
  xBallPos = width/4;
  yBallPos = height/6;

  //Scoreboard
  score = 0;
  if (gameOver || ActiveSettings[noGameOver] )  // Only reset Level after a game over.
  {
    // Ball Speed
    xspeed = 3;
    yspeed = 3;
    // Game Level
    level = 1;
  }

  playerNameStatus = false;    // reset player name.

  //gameover
  gameOver = false;         // reset game over.
  angleRotate = 0.0;        // reset angle of rotation.

  currentScreen = mainScreen;      // Set the current screen to main screen

  //paddle
  yPaddlePos = height - edge +rad;      // y Position of the paddle
  PaddleSize ();                        // set paddle size

  //Restart Button position and size
  xRestartButton = 500;
  yRestartButton = 600;
  xRestartButton2 = 500;
  yRestartButton2 = 750;
  wRestartButton = 150;
  hRestartButton = 60;
  rRestartButton = 10;

  //Default Colors
  defaultScreenColor = color(#46CED1);     // Turquoise
  notPressedButtonColor = color(#EA8421);  // Tango
  pressedButtonColor = color(#F9DABC);     // Tango 70% tints
  scoreboardColor = color(#6006C7);        // Purple
  settingsOn = color(#73F95E);             // light Green
  settingsOff = color(#22582F);            // Dark Green
  defaultTitleColor = color(#000000);       // Black
  countDown = color(#0B9E35);               // Dark Green

  //title size
  defaultTitleSize = 60;

  // Titles starting coordinates
  xyBounceTitles[0] = width/4;
  xyBounceTitles[1] = width/4;

  timerIsSet = false;  // reset timer.
}

//Draw *************************************************************************************************
void draw()
{
  background(102); // set background screen. (outter screen)
  // Show student details size , aligment and color
  textSize(20);
  textAlign(LEFT);
  fill(255);
  // Show student details
  text("Student: "+studentName, 50, 20);
  text("Student ID: "+studentID, 50, 785);

  // Controls the flow between screens
  switch(currentScreen)
  {
  case "mainScreen":
    showMainScreen();
    break;

  case "Start":
    showGameScreen();
    break;

  case "Level: <L>":
    showLevelSelection();
    break;

  case "Settings":
    showSettings();
    break;
  }

  if (ActiveSettings[showParam]) // call debugParam if showParam settings are activated.
  {
    debugParam ();
  }
}

// INITIAL SCREEN *********************************************************************************************************************
void showMainScreen()
{
  //Inner Screen color and size
  fill(defaultScreenColor);
  setInnerScreenSize ();

  //Bounce Titles and big ball
  xyBounceTitles = bounceTitles (xyBounceTitles[0], xyBounceTitles[1]);  // get x y position
  fill(255);
  ellipse(xyBounceTitles[0], xyBounceTitles[1], titleBallrad, titleBallrad);
  placeTitles( gameTitle, defaultTitleSize, xyBounceTitles[0], xyBounceTitles[1], defaultTitleColor  );

  //Setting up Buttons
  for (int i=0; i < xInitialButtons.length; i++ )
  {
    ButtonOverP1[i] = overButtons(xInitialButtons[i], yInitialButtons, sizeStartButtons[0], sizeStartButtons[1]);
    if (ButtonOverP1[i])
    {
      placeButtons ( buttonsLabel[i].replace(Levelplace, ""+level), xInitialButtons[i], yInitialButtons, sizeStartButtons[0], sizeStartButtons[1], sizeStartButtons[2], pressedButtonColor );
    } else
    {
      placeButtons ( buttonsLabel[i].replace(Levelplace, ""+level), xInitialButtons[i], yInitialButtons, sizeStartButtons[0], sizeStartButtons[1], sizeStartButtons[2], notPressedButtonColor );
    }
  }
}

// GAME RUNNING ***********************************************************************************************************************************
void showGameScreen()
{

  //Inner Screen color and size. xspeed controls HUE. The color varies accordingly to level.
  colorMode(HSB, 27 );  // hue variation
  fill(xspeed, 25, 25 );  //color
  setInnerScreenSize ();  //size
  colorMode(RGB, 255, 255, 255); // back to default color mode

  //Setting up ScoreBoard
  String [] ScoreBoardResults = { playerName, ""+score, ""+level}; // create an array with current scoreboard results

  for (int i=0; i < xScoreBoard.length; i++ )
  {
    placeButtons ( scoreBoardLabel[i]+ScoreBoardResults[i], xScoreBoard[i], yScoreBoard, sizeScoreBoard[0], sizeScoreBoard[1], sizeScoreBoard[2], scoreboardColor );
  }

  // Get Player name
  if (!playerNameStatus)
  {
    playerName = JOptionPane.showInputDialog(
      "Welcome to Bouncing Ball\n\n " + "Please enter your Name: ",
      "Player 1");
    playerNameStatus = true;

    // formatting Player name. it should be with no spaces and the first letter is upper case.
    if (playerName != null && playerName != "" && playerName != " " ) {
      playerName = playerName.trim();             // remove spaces
      playerName = playerName.toLowerCase();      // all to lower case
      String Firstletter = playerName.substring(0, 1);  // get the first letter
      Firstletter = Firstletter.toUpperCase();          // first letter to upper case
      playerName = Firstletter + playerName.substring(1, playerName.length() );  // replacing the first letter
    } else {
      playerName ="Player 1" ;
    }
  }
  // Game mode. Ball will move only if all of them are false. Paddle is free
  if (!gameOver && !timerIsSet && !pauseGame )
  {
    // Update the position of the Ball
    xBallPos = xBallPos + ( xspeed * xdirection );
    yBallPos = yBallPos + ( yspeed * ydirection );

    // correcting the ball position if it goes beyond the inner screen boundaries
    xBallPos = constrain(xBallPos, inner, width - inner);
    yBallPos = constrain(yBallPos, inner, height - inner);

    // reverse its direction by multiplying by -1 if the ball hits the x boundaries
    if (xBallPos >= width-inner || xBallPos <= inner) {
      xdirection *= -1;
    }
    // reverse its direction by multiplying by -1 if the ball hits the lower y boundaries
    if ( yBallPos <= inner) {
      ydirection *= -1;
    } else if (yBallPos >= height-inner) {          // check if the ball hits the upper y boundaries
      if ( abs(xBallPos-xPaddlePos) <= wPaddleSize/2 )    // check if the paddle is underneath. if TRUE , game continues. otherwise is Game over.
      {
        // set ball speed and scoreboard . ball speed increases every time , it is hit with the paddle.
        xspeed += speedRate;
        yspeed += speedRate;
        level = 1+int((xspeed-minSpeed)/levelRange);
        score += 1*level;
        if (xBallPos-xPaddlePos <= 0)
        {
          xdirection = -1;
          ydirection *= -1;
        } else
        {
          xdirection = 1;
          ydirection *= -1;
        }
      } else   //Game over
      {
        gameOver = true;
      }
    }
  } else if (gameOver) {

    //ReStart Button
    placeRestartButton();

    //GAME OVER color size and aligment
    fill(0);
    textSize(80);
    textAlign(CENTER, CENTER);

    //GAME OVER text , rotation
    pushMatrix();
    translate(500, 400);
    rotate(radians(angleRotate));
    text(gameOverStr, 0, 0);
    popMatrix();
    angleRotate += 0.5;
  } else if (pauseGame) { // pause button to resume game
    placeButtons ( pauseMessage, pauseParam[0], pauseParam[1], pauseParam[2], pauseParam[3], pauseParam[4], countDown );
  } else {
    //countdown to resume game
    placeButtons ( ""+(timerSecInFrames/frameRateDef+1), countDownParam[0], countDownParam[1], countDownParam[2], countDownParam[3], countDownParam[4], countDown );
    timerSecInFrames--; // timer countdown
    if (timerSecInFrames<=0) // if zero , timer is finished.
    {
      timerIsSet=false;
    }
  }

  // Ball stroke color , stroke line and color
  stroke(0);
  strokeWeight(1);
  fill(255);
  ellipse(xBallPos, yBallPos, rad, rad);

  // Paddle
  xPaddlePos = getXPaddlePosition(mouseX);    // get x position
  rect(xPaddlePos, yPaddlePos, wPaddleSize, hPaddleSize, rad); // draw paddle

  //ReStart Button is NoGameOver is ON
  if (ActiveSettings[noGameOver])
  {
    placeRestartButton();
  }
}

// LEVEL SELECTION ***********************************************************************************************************************************
void showLevelSelection()
{
  //Inner Screen color and size
  fill(defaultScreenColor);
  setInnerScreenSize ();

  //Bounce Titles and big ball
  xyBounceTitles = bounceTitles (xyBounceTitles[0], xyBounceTitles[1]);  // set x y position
  fill(255);
  ellipse(xyBounceTitles[0], xyBounceTitles[1], titleBallrad, titleBallrad);  // big ball
  placeTitles(buttonsLabel[levelButton].substring(0, 5), defaultTitleSize, xyBounceTitles[0], xyBounceTitles[1], defaultTitleColor  );  // title

  //Setting up Buttons
  for (int j=0, c=0; j < yLevelButtons.length; j++ )
  {
    for (int i=0; i < xLevelButtons.length; i++ )
    {
      levelButtonOver[c] = overButtons(xLevelButtons[i], yLevelButtons[j], sizeLevelButtons[0], sizeLevelButtons[1]);
      if (levelButtonOver[c] )
      {
        placeButtons ( ""+(c+1), xLevelButtons[i], yLevelButtons[j], sizeLevelButtons[0], sizeLevelButtons[1], sizeLevelButtons[2], pressedButtonColor );
      } else
      {
        if (level == c+1) {
          placeButtons (""+(c+1), xLevelButtons[i], yLevelButtons[j], sizeLevelButtons[0], sizeLevelButtons[1], sizeLevelButtons[2], settingsOn);
        } else {
          placeButtons (""+(c+1), xLevelButtons[i], yLevelButtons[j], sizeLevelButtons[0], sizeLevelButtons[1], sizeLevelButtons[2], notPressedButtonColor);
        }
      }
      c++;
    }
  }

  //ReStart Button in a specific location
  placeRestartButton( xRestartButton2, yRestartButton2);
}

// SETTINGS ***********************************************************************************************************************************
void showSettings()
{

  //Inner Screen size and color
  fill(defaultScreenColor);
  setInnerScreenSize ();

  //Bounce Titles and big ball
  xyBounceTitles = bounceTitles (xyBounceTitles[0], xyBounceTitles[1]);  // set x y position
  fill(255);
  ellipse(xyBounceTitles[0], xyBounceTitles[1], titleBallrad, titleBallrad);  // big ball
  placeTitles( buttonsLabel[settingsButton], defaultTitleSize, xyBounceTitles[0], xyBounceTitles[1], defaultTitleColor  ); // title

  //Instructions it has its own parameters like size color and position
  placetext (mainInstructions, width/2, height/4, 25);

  //Setting up Buttons
  for (int j=0, c=0; j < ySettingsButtons.length; j++ )
  {
    for (int i=0; i < xSettingsButtons.length; i++ )
    {
      SettingsButtonOver[c] = overButtons(xSettingsButtons[i], ySettingsButtons[j], sizeSettingsButtons[0], sizeSettingsButtons[1]);

      if (ActiveSettings[c])
      {
        placeButtons (SettingsLabel[c] + "ON", xSettingsButtons[i], ySettingsButtons[j], sizeSettingsButtons[0], sizeSettingsButtons[1], sizeSettingsButtons[2], settingsOn );
        placetext (BInstructions[c], xSettingsButtons[i], ySettingsButtons[j]+60, 15);//Instrucitons
      } else
      {
        placeButtons (SettingsLabel[c] + "OFF", xSettingsButtons[i], ySettingsButtons[j], sizeSettingsButtons[0], sizeSettingsButtons[1], sizeSettingsButtons[2], settingsOff);
        placetext (BInstructions[c], xSettingsButtons[i], ySettingsButtons[j]+60, 15);//Instrucitons
      }
      c++;
    }
  }

  //ReStart Button in a default position
  placeRestartButton();
}

// GENERAL METHODS*************************************************************************************************************************************
// set level and increase ball speed
void setLevel(int levelPicked)
{
  level = levelPicked;                    // set level
  xspeed = minSpeed + levelPicked*levelRange;  // Ball Speed
  yspeed = minSpeed + levelPicked*levelRange;  // Ball Speed
}

// Place title on the screen
void placeTitles(String title, int  titleSize, int xPos, int yPos, color titlecolor  )
{
  //Screen Title
  textSize(titleSize);
  textAlign(CENTER, CENTER);
  fill(titlecolor);
  text(title, xPos, yPos);
}

// Creating Buttons or Scoreboard on screen. create a rectangle and its label
void placeButtons ( String ButtonLabel, int x, int y, int bWidth, int bHeight, int bRadius, color ButtonColor )
{
  textSize(25);
  textAlign(CENTER, CENTER);
  stroke(255);
  strokeWeight(3);
  fill(ButtonColor);
  rect(x, y, bWidth, bHeight, bRadius);  // rectangle
  fill(255);
  text(ButtonLabel, x, y);   // label
}

// Setthing the inner screen size
void setInnerScreenSize ()
{
  // Inner screen size
  rect(width/2, height/2, width-2*edge, height-2*edge);
}

// returns the paddle position on the X axis
int getXPaddlePosition(int playerAxisX)
{
  // this IFs/ELSEs are to hold the paddle within the inner screen boundaries
  if (mouseX <= edge+wPaddleSize/2)
    playerAxisX=edge+wPaddleSize/2;
  else if (mouseX >= width-edge-wPaddleSize/2)
    playerAxisX= width-edge-wPaddleSize/2;
  else
    playerAxisX=mouseX;

  return playerAxisX;
}

// Create a timer. transform seconds in number of frames.
void Timer(int secs)
{
  timerSecInFrames = secs*frameRateDef;
  timerIsSet = true;
}

// Show hidden parameters on screen, activated in settings screen
void debugParam ()
{
  // hold the variable names
  String [] column1Names = {"Paddle", "xPaddlePos", "yPaddlePos", "wPaddleSize", "Ball Position", "xBallPos", "yBallPos", "rad", "xspeed", "yspeed",
    "xdirection", "ydirection", "Game", "score", "level", "timerSecInFrames", "playerName", "currentScreen",
    "playerNameStatus", "gameOver", "timerIsSet", "showParam", "noGameOver", "Pause", "DoublePaddleSize", "angleRotate"};
  // hold the variable values
  String [] column1Values ={"", ""+(xPaddlePos), ""+(yPaddlePos), ""+(wPaddleSize), "", ""+(xBallPos), ""+(yBallPos), ""+(rad), ""+(xspeed), ""+(yspeed),
    ""+(xdirection), ""+(ydirection), "", ""+(score), ""+(level), ""+(timerSecInFrames), playerName, currentScreen,
    ""+(playerNameStatus), ""+(gameOver), ""+(timerIsSet), ""+(ActiveSettings[showParam]), ""+(ActiveSettings[noGameOver]),
    ""+(ActiveSettings[Pause]), ""+(ActiveSettings[DoublePaddleSize]), ""+(angleRotate)};

  // text size, color and aligment
  fill(#FC03F0);
  textSize(10);
  textAlign(CENTER, CENTER);

  // iterate through the array of variables
  int i=0, c=0, j=0;
  while (i < xParameters.length)
  {
    j=0;
    while (j < yParameters)
    {
      if (c < column1Names.length)
      {
        text(column1Names[c]+ ": " + column1Values[c], xParameters[i], 100+j*10);
        c++;
      }
      j++;
    }
    i++;
  }
}

// Set Padlle Size
void PaddleSize ()
{
  if (ActiveSettings[noGameOver])
  {
    wPaddleSize = wPaddleNoGameOver;
  } else if (ActiveSettings[DoublePaddleSize])
  {
    wPaddleSize = wPaddleDouble;
  } else
  {
    wPaddleSize = wPaddleDefault;
  }
}

//place Restart Button in a specific place
void placeRestartButton(int x, int y)
{

  restartButtonOver = overButtons(x, y, wRestartButton, hRestartButton); // check if pointer is over restart button
  if (restartButtonOver)
  {
    placeButtons ( restartButtonStr, x, y, wRestartButton, hRestartButton, rRestartButton, pressedButtonColor);
  } else
  {
    placeButtons ( restartButtonStr, x, y, wRestartButton, hRestartButton, rRestartButton, notPressedButtonColor);
  }
}
//place Restart Button in a default place
void placeRestartButton()
{

  restartButtonOver = overButtons(xRestartButton, yRestartButton, wRestartButton, hRestartButton);
  if (restartButtonOver)
  {
    placeButtons ( restartButtonStr, xRestartButton, yRestartButton, wRestartButton, hRestartButton, rRestartButton, pressedButtonColor);
  } else
  {
    placeButtons ( restartButtonStr, xRestartButton, yRestartButton, wRestartButton, hRestartButton, rRestartButton, notPressedButtonColor);
  }
}

// return the x y position to make the titles bounce on the screen
int[] bounceTitles (int x, int y)
{
  int [] xyCoordinates = {x, y};

  // Update the position / Level bouncing speed will vary accordingly with the level picked
  if (currentScreen == buttonsLabel[levelButton]) {
    xyCoordinates[0] = int(xyCoordinates[0] + ( xspeed * xdirection)); // x
    xyCoordinates[1] = int(xyCoordinates[1] + ( yspeed * ydirection )); // y
  } else {
    xyCoordinates[0] = int(xyCoordinates[0] + ( minSpeed * xdirection)); // x
    xyCoordinates[1] = int(xyCoordinates[1] + ( minSpeed * ydirection )); // y
  }

  // check if the ball it is within the inner screen boundaries. it changes direction when it hits the boundaries
  if (xyCoordinates[0] >= width-(titleBallrad+edge) || xyCoordinates[0] <= (titleBallrad+edge)) {
    xdirection *= -1;
  }
  if (xyCoordinates[1] >= height-(titleBallrad+edge) || xyCoordinates[1] <= (titleBallrad+edge)) {
    ydirection *= -1;
  }
  return xyCoordinates;
}

// place a text on screen in a specific location .
void placetext (String text, int x, int y, int size)
{
  fill(#000000);
  textSize(size);
  textAlign(CENTER, CENTER);
  text(text, x, y);
}

// MOUSE ACTIONS *******************************************************************************************************************************************
// Controls the flow of button actions by the screen location
void mouseReleased()
{
  int i = 0; // Varible for WHILEs statements below
  switch(currentScreen) // switching between screens
  {
  case "mainScreen":
    // Main Screen Button
    while (i < ButtonOverP1.length)
    {
      if (ButtonOverP1[i])
      {
        currentScreen = buttonsLabel[i];
        if (currentScreen == "Start")
        {
          Timer(3);
        }
      }
      i++;
    }
    break;

  case "Start":
    // Restart Button
    restartButtonOver = overButtons(xRestartButton, yRestartButton, wRestartButton, hRestartButton);
    if (restartButtonOver)
    {
      initialize();
    }
    break;

  case "Level: <L>":
    // Restart Button
    restartButtonOver = overButtons(xRestartButton2, yRestartButton2, wRestartButton, hRestartButton);
    if (restartButtonOver)
    {
      initialize();
    }
    // Level Buttons
    while (i < levelButtonOver.length)
    {
      if (levelButtonOver[i])
      {
        setLevel(i+1);
      }
      i++;
    }
    break;

  case "Settings":
    // Level Buttons
    while (i < SettingsButtonOver.length)
    {
      if (SettingsButtonOver[i] && mouseButton == LEFT )
      {
        ActiveSettings[i] = true;
      } else if (SettingsButtonOver[i] && mouseButton == RIGHT)
      {
        ActiveSettings[i] = false;
      }
      i++;
    }

    // Restart Button
    if (restartButtonOver)
    {
      initialize();
    }
    break;
  }
}
// Controls Pause funcion
void mousePressed()
{
  // Pause Function
  if (ActiveSettings[Pause] && mouseButton == CENTER && !pauseGame ) {
    pauseGame = true;
  } else if (ActiveSettings[Pause] && mouseButton == CENTER && pauseGame ) {
    pauseGame = false;
    Timer(3);
  }
}

// Checking if pointer is over any buttons
boolean overButtons(int x, int y, int width, int height)
{
  if ( abs(mouseX-x) <= width/2 && abs(mouseY-y) <= height/2)
  {
    return true;
  } else
  {
    return false;
  }
}
