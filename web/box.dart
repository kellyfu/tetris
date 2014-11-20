library box;
import 'dart:html';

const Leftmargin = 150;
const Topmargin = 150;

class Box
{
  DivElement boxDiv = new DivElement();
  List<String> boxColor = ['white','red', 'yellow', 'blue', 'green', 'orange'];
  int leftpo;
  int toppo;

  Box(this.leftpo,this.toppo,int color)
  {
      leftpo = Leftmargin+leftpo*30;
      toppo = Topmargin+toppo*30;
      boxDiv.style.left = px(leftpo);
      boxDiv.style.top = px(toppo);
      boxDiv.style.backgroundColor = boxColor[color];
      boxDiv.classes.add("box");
      
  }
  
  String getcolor()
  {
    return boxDiv.style.backgroundColor;
  }
  String px(num number) {
    return "${number}px";
  }
}