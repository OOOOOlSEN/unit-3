//colors - Defines the color palette for the drawing app
color c1 = #556720;      // Olive green
color c2 = #4ECDC4;      // Turquoise
color c3 = #C7F464;      // Lime green
color c4 = #FF6B6B;      // Salmon pink
color c5 = #C44D58;      // Burgundy
color c6 = #FFFFFF;      // White
color settings = #2A2C31; // Dark gray for UI elements
color selected;          // Stores the currently selected drawing color

//variables
float sw;                // Stores the stroke width (brush size)
int Gis, His, Zis;       // Status flags for image stamps (different game logos)
PImage Gi, Hi, Zi;       // Image objects for the game logos

// Setup function - runs once at the start
void setup(){
  size(1200,1000);       // Set canvas size
  background(c6);        // Set background to white
  selected=c1;           // Set default color to olive green
  sw=400;                // Set default stroke width
  // Load game logo images
  Gi=loadImage("game-logo-icon-38.png");
  Hi=loadImage("games-png-games-png-transparent-2400.png");
  Zi=loadImage("ori_3680144_3snt0ha97hu7ol7j2q87ygxdjqlzszpjph0jcs58_gamer-esport-mascot-logo-design.png");
  // Initialize stamp flags to inactive (-1)
  Gis=-1;
  His=-1;
  Zis=-1;
  // Set text properties
  textAlign(CENTER,CENTER);
  textSize(30);
}

// Draw function - runs continuously to update the display
void draw(){
  // Draw UI panel at the top
  fill(255);
  stroke(0);
  strokeWeight(1);
  fill(settings);
  rect(0,0,1200,200);    // Dark gray panel for controls
  
  // Draw color selection circles with tactile (hover) effects
  tactile(70,60,35);
  fill(c1);
  circle(70,60,70);      
  tactile(70,140,35);
  fill(c2);
  circle(70,140,70);     
  tactile(160,60,35);
  fill(c3);
  circle(160,60,70);     
  tactile(160,140,35);
  fill(c4);
  circle(160,140,70);    
  tactile(250,60,35);
  fill(c5);
  circle(250,60,70);     
  tactile(250,140,35);
  fill(c6);
  circle(250,140,70);    
  
  // Stroke width slider
  stroke(200);
  line(350,50,500,50);   // Slider line
  circle(sw,50,20);      // Slider handle
  fill(selected);
  circle(425,120,(sw-300)/5); // Preview of current brush size and color
  
  // Stamp buttons for game logos
  // First game logo button
  tactileim(550,10,210,80);
  GOnOff();              // Highlights if selected
  rect(550,10,210,80);
  image(Gi,555,10,198,74);
  
  // Second game logo button
  tactileim(550,105,210,80);
  HOnOff();              // Highlights if selected
  rect(550,105,210,80);
  image(Hi,570,83,169.1,133);
  
  // Third game logo button
  tactileim(770,20,155,155);
  ZOnOff();              // Highlights if selected
  rect(770,20,155,155);
  image(Zi,777,30,140,140);
  
  // File operation buttons
  // New canvas button
  tactilere(950,15,200,50);
  strokeWeight(3);
  fill(settings);
  rect(950,15,200,50);
  tactileword(950,15,200,50);
  text("New",1050,35);
  
  // Load image button
  tactilere(950,75,200,50);
  strokeWeight(3);
  fill(settings);
  rect(950,75,200,50);
  tactileword(950,75,200,50);
  text("Load",1050,95);
  
  // Save image button
  tactilere(950,135,200,50);
  strokeWeight(3);
  fill(settings);
  rect(950,135,200,50);
  tactileword(950,135,200,50);
  text("Save",1050,155);
}

// Function for rectangle hover effect - changes stroke color when hovering over rectangular buttons
void tactilere(int X1, int Y1, int X2, int Y2){  
  if (mouseX > X1 && mouseX < X2+X1 && mouseY < Y2+Y1 && mouseY > Y1){
    stroke(255);         // White stroke when hovering
  }
  else{
    stroke(0);           // Black stroke when not hovering
  }
}

// Function for text hover effect - changes text color when hovering over button text
void tactileword(int X1, int Y1, int X2, int Y2){  
  if (mouseX > X1 && mouseX < X2+X1 && mouseY < Y2+Y1 && mouseY > Y1){
    fill(255);           // White text when hovering
  }
  else{
    fill(0);             // Black text when not hovering
  }
}

// Function for image button hover effect - changes button background color when hovering over image buttons
void tactileim(int x1, int y1, int x2, int y2){
  if (mouseX > x1 && mouseX < x2+x1 && mouseY < y2+y1 && mouseY > y1){
    fill(255,255,50);    // Yellow background when hovering
  }
  else{
    fill(250);           // Light gray background when not hovering
  }
}

// Function for circular button hover effect - changes stroke color when hovering over circle buttons
void tactile(int x, int y, int r){
  if (dist(x, y, mouseX, mouseY) < r){
    stroke(255);         // White stroke when hovering
  }
  else{
    stroke(0);           // Black stroke when not hovering
  }
}

// Mouse click handler - processes user clicks on various UI elements
void mouseReleased(){
  // Color selection logic
  if (dist(70,60,mouseX,mouseY)<35){ selected=c1; }    
  if (dist(70,140,mouseX,mouseY)<35){ selected=c2; }  
  if (dist(160,60,mouseX,mouseY)<35){ selected=c3; }   
  if (dist(160,140,mouseX,mouseY)<35){ selected=c4; }  
  if (dist(250,60,mouseX,mouseY)<35){ selected=c5; }  
  if (dist(250,140,mouseX,mouseY)<35){ selected=c6; }  
  
  controllslider();      // Update slider position if clicked
  
  // Stamp selection logic (only one can be active at a time)
  if (mouseX > 550 && mouseY > 10 && mouseX < 760 && mouseY < 90){ Gis*=-1; His=-1; Zis=-1; }      // Toggle first game logo
  else if (mouseX > 550 && mouseY > 105 && mouseX < 760 && mouseY < 185){ His*=-1; Gis=-1; Zis=-1; } // Toggle second game logo
  else if (mouseX > 770 && mouseY > 20 && mouseX < 925 && mouseY < 175){ Zis*=-1; His=-1; Gis=-1; }  // Toggle third game logo
  
  // File operations
  if (mouseX > 950 && mouseY> 15 && mouseX < 1150 && mouseY < 65){ background(255); }  // New canvas (clear to white)
  if (mouseX > 950 && mouseY> 75 && mouseX < 1150 && mouseY < 125){ selectInput("Pick an image","openImage"); }  // Open file dialog
  if (mouseX > 950 && mouseY> 135 && mouseX < 1150 && mouseY < 185){ selectOutput("Choose a name for your masterpiece","saveImage"); }  // Save file dialog
}

// Mouse drag handler for drawing or placing stamps
void mouseDragged(){
  if (Gis < 0 && His < 0 && Zis < 0) {
    // If no stamps are active, draw with brush
    strokeWeight((sw-300)/5);  // Set brush size based on slider
    stroke(selected);          // Use selected color
    line(pmouseX, pmouseY, mouseX, mouseY);  // Draw line from previous to current mouse position
    controllslider();          // Update slider if dragged
  }
  else{
    // If a stamp is active, place the stamp at mouse position
    if (Gis > 0){ image(Gi,mouseX-100,mouseY-25,sw/2,sw*0.37373737373/2); }  // Place first game logo
    if (His > 0){ image(Hi,mouseX-150,mouseY-120,sw*0.8,sw*0.62921348); }    // Place second game logo
    if (Zis > 0){ image(Zi,mouseX-60,mouseY-55,sw/3,sw/3); }                 // Place third game logo
  }
}

// Update slider position when dragged
void controllslider(){
  if (mouseX>350 && mouseX<500 && mouseY <150){ sw = mouseX; }  // Set stroke width based on slider position
}

// Visual indicator for first game logo stamp button
void GOnOff(){
  if (Gis>0){ stroke(255,0,0); strokeWeight(5); }  // Red thick border when active
  else{ stroke(0); strokeWeight(1); }              // Normal border when inactive
}

// Visual indicator for second game logo stamp button
void HOnOff(){
  if (His>0){ stroke(255,0,0); strokeWeight(5); }  // Red thick border when active
  else{ stroke(0); strokeWeight(1); }              // Normal border when inactive
}

// Visual indicator for third game logo stamp button
void ZOnOff(){
  if (Zis>0){ stroke(255,0,0); strokeWeight(5); }  // Red thick border when active
  else{ stroke(0); strokeWeight(1); }              // Normal border when inactive
}

// Save the drawing to a file
void saveImage(File data){
  if (data != null){
    PImage canvas = get(0,200,width,height-200);  // Capture only the drawing area (below UI panel)
    canvas.save(data.getAbsolutePath());          // Save to selected file path
  }
}

// Open an image and display it on the canvas
void openImage(File data){
  if (data != null){
    PImage pic = loadImage(data.getPath());  // Load the selected image
    image(pic,0,200);                        // Display it below the UI panel
  }
}
