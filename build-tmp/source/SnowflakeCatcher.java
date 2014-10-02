import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SnowflakeCatcher extends PApplet {

Gas[] mol = new Gas[1024];
public void setup()
{
  frameRate(16);
  size(1024,768);
  background(0);
  for(int i=0;i<mol.length;i++)
  {
    mol[i] = new Gas((int)(Math.random()*1024),(int)(Math.random()*768),Math.random()*2*PI,i);
  }
}
public void draw()
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
public void mouseDragged()
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
  public void collide()
  {
  int c = color(255,255,255);
  if(get(x +(int)(8*Math.cos(angle)),y +(int)(8*Math.sin(angle))) == c)
    {
      angle += PI;
    }
  }
  public void show()
  {
    fill(255);
    ellipse(x, y, 8, 8);
  }
  public void look()
  {
    int c = color(255,0,0);
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
  public void erase()
  {
    noStroke();
    fill(0);
    ellipse(x, y, 10, 10);
  }
  public void move()
  {
    if(isMoving)
    {
      x += (int)(8*Math.cos(angle));
      y += (int)(8*Math.sin(angle));
    }
  }
  public void wrap()
  {
    x %= 1024;
    while(x<0)
    {x += 1024;} 
    y %= 768;
    while(y<0)
    {y += 768;}
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SnowflakeCatcher" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
