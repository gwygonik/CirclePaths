// CirclePaths
// 
// Draw circle-only paths
// by g.wygonik

float angle = 0.0;
int count = 0;
float centerX, centerY, oldX, oldY;
float radius = 40.0;
boolean alternateDir = true;
int countReset;
float pathStrokeSize = 2.0;

void setup() {
  // basic setup
  size(700,700);
  pixelDensity(2);
  background(250);

  // set the starting point to a 
  // random location near the middle
  // of the screen
  centerX = random(200,width-200);
  centerY = random(200,height-200);
  oldX = centerX;
  oldY = centerY;
  
  countReset = 600;// start with almost a full circle
  // or: 
  // countReset = (int)random(55,350); // start with random
  
}

void draw() {
  // augment the main path
  noFill();
  stroke(0,200,255,8);
  // try one of these two next lines
  //line(cX,cY,cX+sin(ang)*r,cY+cos(ang)*r);
  ellipse(centerX+sin(angle)*(radius*2.0),centerY+cos(angle)*(radius*2.0),radius*2,radius*2);

  // draw the main path, here made of little circles
  // so we can adjust the size/alpha/color if we want
  noStroke();
  fill(0,100,155,180);
  ellipse(centerX+sin(angle)*radius,centerY+cos(angle)*radius,pathStrokeSize,pathStrokeSize);
  
  // use these to adjust the size of the path
  //pathStrokeSize = max(1, pathStrokeSize + (0.01 * (alternateDir ? -1.0 : 1.0)));
  // or
  //pathStrokeSize = 5.0 + sin(angle)*10.0;
  
  count++;
  if (count > countReset) {
    // pick a new circle radius
    float newRadius = random(10.0,90.0);
    
    // determine new circle's center point,
    // offset from old center point and old radius
    centerX = oldX+sin(angle)*((radius*2.0+(newRadius-radius)));
    centerY = oldY+cos(angle)*((radius*2.0+(newRadius-radius)));
    
    // set old center to new center
    oldX = centerX;
    oldY = centerY;

    // set new radius
    radius = newRadius;

    // since we moved to a circle on the outer
    // side of the old circle, we need to flip
    // the angle around too
    angle -= PI;
    // and move the other way
    alternateDir = !alternateDir;
    
    // start counting again
    count = 0;
    countReset = (int)random(200,650);
  }
  
  // move along the circle's perimeter.
  // change the value for faster/slower,
  // but be aware that the counterReset
  // values may need to change too
  angle += alternateDir ? -0.01 : 0.01;
}

void keyPressed() {
  // save the image if you press spacebar
  if (key == ' ') {
    save("circles_" + millis() + ".png");
    println("SAVED");
  }
}