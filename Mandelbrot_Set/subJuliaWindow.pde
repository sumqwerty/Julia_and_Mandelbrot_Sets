class PWindow extends PApplet
{
  PWindow()
  {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  void settings()
  {
    size(640, 480);
  }
  
  void setup()
  {
    colorMode(HSB,1);
  }
  
  void draw()
  {
    float w = juliaZoom;
    float h = (w * height) / width;
    float xmin = -w/2;
    float ymin = -h/2;
    loadPixels();
    
    int maxiterations = 100;
  
    // x goes from xmin to xmax
    float xmax = xmin + w;
    // y goes from ymin to ymax
    float ymax = ymin + h;
  
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

          if (a*a + b*b > 16.0) 
          {
            break;
          }
          
          float twoab = 2.0 * a * b;
          a = aa - bb + creal;
          b = twoab + cimg;
          
          n++;
        }
  
        if (n == maxiterations) 
        {
          pixels[i+j*width] = color(0);
        } 
        else 
        {
          float hu = (sqrt(float(n) / maxiterations));
          pixels[i+j*width] = color(hu,255,255);
          //pixels[i+j*width] = color(hu);
        }
        x += dx;
      }
      y += dy;
    }
    updatePixels();
  }
}
