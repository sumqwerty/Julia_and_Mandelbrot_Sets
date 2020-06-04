PWindow win;
float juliaZoom = 5;

float creal = 0;
float cimg = 0;

float pntrX = 0;
float pntrY = 0;

void settings()
{
  size(640, 480);
}

void setup() 
{
  win = new PWindow();
  colorMode(HSB, 1);
}
void draw() 
{
  background(255);

  float w = 4;
  float h = (w * height) / (width);
  //println(h);
    
  // Start at negative half the width and height
  float xmin = -w/2;
  float ymin = -h/2;

  loadPixels();

  // Maximum number of iterations for each point on the complex plane
  int maxiterations = 500;

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  if(mousePressed && mouseButton == LEFT)
  {
    sel(xmin, xmax, ymin, ymax);
  }

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);



  // Start y
  float y = ymin;
  for (int j = 0; j < height; j++) 
  {
    // Start x
    float x = xmin;
    for (int i = 0; i < width; i++) 
    {
      float a = x;
      float b = y;

      int n = 0;
      while (n < maxiterations) 
      {
        float aa = a * a;
        float bb = b * b;
        if (aa + bb > 16.0) 
        {
          break;  // Bail
        }
        float twoab = 2.0 * a * b;
        a = aa - bb + x;
        b = twoab + y;
        
        n++;
      }

      if (n == maxiterations) 
      {
        pixels[i+j*width] = color(0);
      } 
      else 
      {
        float hu = sqrt(float(n) / maxiterations);
        pixels[i+j*width] = color(hu,255,255);
        //pixels[i+j*width] = color(hu);
      }
      x += dx;
    }
    y += dy;
  } 
  updatePixels();
  //noFill();
  //stroke(255,255,255);
  //circle(pntrX,pntrY,10);
  //println(map(mouseX,0,width,xmin,xmax), map(mouseY,0,height,ymin,ymax));
}


void sel(float xmin, float xmax, float ymin, float ymax)
{
  pntrX = mouseX;
  pntrY = mouseY;
  creal = map(mouseX,0,width,xmin,xmax);
  cimg = map(mouseY,0,height,ymin,ymax);
}

void keyPressed()
{
  if(key == 'z')juliaZoom -= 0.1;
  else if(key == 'x')juliaZoom += 0.1;
  
  if(juliaZoom > 5)juliaZoom = 5;
  else if(juliaZoom < 0.5)juliaZoom = 0.5;
  
}
