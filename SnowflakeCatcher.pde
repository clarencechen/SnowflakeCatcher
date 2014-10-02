Gas[] mol = new Gas[512];
void setup()
{
  frameRate(16);
  size(1024,768);
  background(0);
  for(int i=0;i<mol.length;i++)
  {
    mol[i] = new Gas((int)(Math.random()*1024),(int)(Math.random()*768),Math.random()*2*PI,i);
  }
}
void draw()
{
  for(int i=0;i<mol.length;i++)
  {
    mol[i].erase();
    mol[i].look();
    mol[i].collide();
    
    mol[i].move();
    mol[i].wrap();
    mol[i].show();
  }
}
void mouseDragged()
{
  if(mouseButton == LEFT)
  { 
    noStroke();
    fill(255,0,0);
    ellipse(mouseX,mouseY,32,32);
  }
  else if (mouseButton == RIGHT)
  {
    noStroke();
    fill(0);
    ellipse(mouseX,mouseY,32,32);
  }
}

class Gas
{
  int x;
  int y;
  double angle;
  boolean isMoving;
  int id;
  Gas(int x, int y, double angle, int id)
  {
    this.x = x;
    this.y = y;
    this.angle = angle;
    isMoving = true;
    this.id = id;
  }
  void collide()
  {
  color c = color(255,255,255);
  if(get(x +(int)(8*Math.cos(angle)),y +(int)(8*Math.sin(angle))) == c)
    {
      angle += PI;
    }
  }
  void show()
  {
    fill(255);
    ellipse(x, y, 8, 8);
  }
  void look()
  {
    color c = color(255,0,0);
    for(double ang = angle-PI;ang<=angle+PI;ang+=PI/12)
    {
      if(get(x +(int)(6*Math.cos(ang)),y +(int)(6*Math.sin(ang))) == c)
      {
        isMoving = false;
        break;
      }
      else
      {
        isMoving = true;
      }
    }
  }
  void erase()
  {
    noStroke();
    fill(0);
    ellipse(x, y, 10, 10);
  }
  void move()
  {
    if(isMoving)
    {
      x += (int)(8*Math.cos(angle));
      y += (int)(8*Math.sin(angle));
    }
  }
  void wrap()
  {
    x %= 1024;
    while(x<0)
    {x += 1024;} 
    y %= 768;
    while(y<0)
    {y += 768;}
  }
}
