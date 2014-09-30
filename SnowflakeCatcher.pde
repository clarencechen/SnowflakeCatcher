Gas[] mol = new Gas[1024];
void setup()
{
  frameRate(16);
  size(768,768);
  background(0);
  for(int i=0;i<mol.length;i++)
  {
    mol[i] = new Gas((int)(Math.random()*768),(int)(Math.random()*768),Math.random()*2*PI,i);
  }
}
void draw()
{
  for(int i=0;i<mol.length;i++)
  {
    mol[i].collide();
    mol[i].look();
    mol[i].erase(); 
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
    ellipse(mouseX,mouseY,16,16);
  }
  else if (mouseButton == RIGHT)
  {
    noStroke();
    fill(0);
    ellipse(mouseX,mouseY,16,16);
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
    if(get(x +(int)(6*Math.cos(angle)),y +(int)(6*Math.sin(angle))) == c)
    {
      angle += PI;
    }
  }
  void show()
  {
    fill(255);
    ellipse(x, y, 6, 6);
  }
  void look()
  {
    color c = color(255,0,0);
    if(get(x +(int)(6*Math.cos(angle)),y +(int)(6*Math.sin(angle))) == c)
    {
      isMoving = false;
    }
    else
    {
      isMoving = true;
    }
  }
  void erase()
  {
    noStroke();
    fill(0);
    ellipse(x, y, 8, 8);
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
    x %= 768;
    while(x<0)
    {x += 768;} 
    y %= 768;
    while(y<0)
    {y += 768;}
  }
}


