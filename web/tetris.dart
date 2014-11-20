import 'dart:html';
import 'box.dart';
import 'dart:math';
import 'dart:async';

const Leftmargin = 200;
const Topmargin = 200;
List <String> boxColor = ['#ffd700','#f08080'];
//List<String> boxColor = ['red', 'yellow', 'blue', 'green', 'orange'];
//List <box> kind_n;
String init_color;
List<List<Box>> box_n = new List(15);
List<List<int>> position = new List(4);
Random random = new Random();
int color;
Timer timer;
int type;
int state;
const LEFT = 37;
const RIGHT = 39;
const UP = 38;
const DOWN = 40;

void main() {
    start();
    fall();
    listen();
    
    
}
void fall()
{
  const TIMEOUT = const Duration(seconds: 1);
 
   timer = new Timer.periodic(TIMEOUT, handleTimeout);
  
  
}
//*/
void listen()
{
  document.onKeyDown.listen((KeyboardEvent evt){
          if(evt.keyCode == LEFT) {
            move(0);
          } else if(evt.keyCode == RIGHT) {
             move(1);
          } else if(evt.keyCode == UP) {
              rotate();
          } else if(evt.keyCode == DOWN) {
            move(2);
          }
      });
}
void handleTimeout(Timer timer)  // callback function
{ 

    change_position();
   
      
      
    
    
  
}

void move(int style)
{
  int i;
  int flag = 0;
  int left_min;
  
  for(i=0;i<4;i++)
  {
    if(style == 0){
      flag = if_moveleft();
      if(position[i][1] - 1 < 0 )
      {
        flag = 1;
        break;
      }
    }
    if(style == 1)
    {
      flag = if_moveright();
      if(position[i][1] + 1 > 9 )
      {
        flag = 1;
        break;
      }
    }
    if(style == 2)
    {
      flag = if_movedown();
      if(position[i][0] + 1 > 14 )
      {
        flag = 1;
        break;
      }
    }
  }
  
  if(flag == 0)
  {
         for(i=0;i<4;i++)
         {
           if(position[i][0] > -1)
            box_n[position[i][0]][position[i][1]].boxDiv.style.backgroundColor =  'white';
         }
         if(style == 0)
         {
            for(i=0;i<4;i++)
              position[i][1]--;
         }
         if(style == 1)
         {
           for(i=0;i<4;i++)
            position[i][1]++;
         }
         if(style == 2)
         {
           for(i=0;i<4;i++)
             position[i][0]++;
         }
         for(i=0;i<4;i++)
         {
           if(position[i][0] > -1)
           box_n[position[i][0]][position[i][1]].boxDiv.style.backgroundColor =  boxColor[color];
         }
  }
}

void check_clear()
{
    int i,j,k;
    int t1,t2;
    int flag = 0;
    int max = -1,min = 20;
    for(i=0;i<4;i++)
    {
      if(position[i][0] > max)
        max = position[i][0];
      if(position[i][0] < min)
        min = position[i][0];
    }
    for(i=0;i<=max-min;i++)
    {
      for(j=min;j<=max;j++)
      {
        flag = 0;
        for(k=0;k<10;k++)
        {
          if(box_n[j][k].boxDiv.style.backgroundColor == 'white')
          {
            flag = 1;
            break;
          }
        }
       
        if(flag == 0)
        {
          for(t1 = 0;t1 < 10;t1++)
            box_n[j][t1].boxDiv.style.backgroundColor = 'white';
          for(t1 = j;t1 > 0;t1--)
            for(t2 = 0;t2 < 10;t2++)
              box_n[t1][t2].boxDiv.style.backgroundColor = box_n[t1-1][t2].boxDiv.style.backgroundColor;
          for(t1 = 0;t1 < 10;t1++)
             box_n[0][t1].boxDiv.style.backgroundColor = 'white';
        }
      }
    }
    
}
void change_position()
{
  int i,j;
  int flag ;
  int top = 0;
  flag = if_movedown();
   if(flag == 0)
   {
     for(i=0;i<4;i++)
     {
       if(position[i][0] > -1)
        box_n[position[i][0]][position[i][1]].boxDiv.style.backgroundColor =  'white';
     }
     for(i=0;i<4;i++)
       position[i][0]++;
     for(i=0;i<4;i++)
     {
       if(position[i][0] > -1)
       box_n[position[i][0]][position[i][1]].boxDiv.style.backgroundColor =  boxColor[color];
     }
   }
   else
   {
     top = check_top();
     if(top == 1)
     {
        check_clear();
        creat_item();
     }
      else
       timer.cancel();
   }
}
int if_moveleft()
{
  int i,j;
  int flag=0;
  int flag2=0;
  for(i=0;i<4;i++)
  {
    flag2 = 0;
    for(j=0;j<4;j++)
    {
        if(position[i][1]-1==position[j][1])
        {
          flag2 = 1;
          break;
        }
    }
    if(flag2 == 0)
    {
      if(position[i][1]-1 >= 0&&position[i][0] >= 0)
      {
        if(box_n[position[i][0]][position[i][1]-1].boxDiv.style.backgroundColor != 'white')
         flag = 1;     
   
      }
    }
    if(flag == 1)
      break;
  }
  if(flag == 0)
    return 0;
  else 
    return 1;
  
}
int if_moveright()
{
  int i,j;
    int flag=0;
    int flag2=0;
    for(i=3;i>=0;i--)
    {
      flag2 = 0;
      for(j=0;j<4;j++)
      {
          if(position[i][1]+1==position[j][1])
          {
            flag2 = 1;
            break;
          }
      }
      if(flag2 == 0)
      {
        if(position[i][1]+1 < 10&&position[i][0] >= 0)
        {
          if(box_n[position[i][0]][position[i][1]+1].boxDiv.style.backgroundColor != 'white')
           flag = 1;     
     
        }
      }
      if(flag == 1)
        break;
    }
    if(flag == 0)
      return 0;
    else 
      return 1;
}
int if_movedown()
{
    int i,j;
    int flag = 0;
    int flag_2 = 0;
    int count = 0;
    int top = 0;
    List<int> array = new List(4);
    List<int> tmp = new List(4);
    for(i=0;i<4;i++)
      array[i] = -10;
    for(i=3;i>=0;i--)
    {
      flag_2 = 0;
      for(j=0;j<4;j++)
      {
        
        if(position[i][1]==array[j]||position[i][0] < 0)
        {
             flag_2 = 1;
             break;
        }
        
      }
      if(flag_2 == 0)
      {
        if(position[i][0] > -1)
        {
          array[count] = position[i][1];
          tmp[count] = i;
          count++;
        }
      }
   }
     for(i=0;i<count;i++)
     {    
          if((position[tmp[i]][0]+1 > 14)||(box_n[position[tmp[i]][0]+1][position[tmp[i]][1]].boxDiv.style.backgroundColor!='white')) 
            flag = 1;
     }
     
    return flag;
}
int check_top()
{
  int i;
  int flag = 0;
  for(i=0;i<10;i++)
  {
    if(box_n[0][i].boxDiv.style.backgroundColor !='white')
    {
      flag = 1;
      break;
    }
  }
  if(flag == 0)  //true
    return 1;
  else
    return -1;  //false
}
void start()
{
  InitialBox();
  creat_item();
  
}
void InitialBox()
{
  int i,j,color;
  for(i=0;i<15;i++){
     box_n[i] = new List(10);
     for(j=0;j<10;j++){
        box_n[i][j] = new Box(j,i,0);
        
     }
  }

  DivElement container = querySelector('#for_box');
  for(i = 0;i < 15;i++)
    for(j = 0;j < 10;j++)
      container.nodes.add(box_n[i][j].boxDiv);

}
void creat_item()
{
    color = random.nextInt(2);
    type = random.nextInt(5);
    for(int i=0;i<4;i++)
        position[i] = new List(4);
    if(type == 0) //┴
    {
      // box_n[0][4].boxDiv.style.backgroundColor =  boxColor[color];
       box_n[0][3].boxDiv.style.backgroundColor = boxColor[color];
       box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
       box_n[0][5].boxDiv.style.backgroundColor = boxColor[color];
       position[0][0] = -1; 
       position[0][1] = 4;
       position[1][0] = 0;
       position[1][1] = 3;
       position[2][0] = 0;
       position[2][1] = 4;
       position[3][0] = 0;
       position[3][1] = 5;
       state = 0;
             
    }
    else if(type == 1)//----
    {
      box_n[0][3].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][5].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][6].boxDiv.style.backgroundColor = boxColor[color];
      position[0][0] = 0; 
      position[0][1] = 3;
      position[1][0] = 0;
      position[1][1] = 4;
      position[2][0] = 0;
      position[2][1] = 5;
      position[3][0] = 0;
      position[3][1] = 6;
      state = 0;
             
    }
    else if(type == 2)//田
    {
     // box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
      //box_n[0][5].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][5].boxDiv.style.backgroundColor = boxColor[color];
      position[0][0] = -1; 
      position[0][1] = 4;
      position[1][0] = -1;
      position[1][1] = 5;
      position[2][0] = 0;
      position[2][1] = 4;
      position[3][0] = 0;
      position[3][1] = 5;
      state = 0;
             
    }
    else if(type == 3)//odd 
    {
     // box_n[0][3].boxDiv.style.backgroundColor = boxColor[color];
      //box_n[1][3].boxDiv.style.backgroundColor = boxColor[color];
      //box_n[1][4].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
      position[0][0] = -2; 
      position[0][1] = 3;
      position[1][0] = -1;
      position[1][1] = 3;
      position[2][0] = -1;
      position[2][1] = 4;
      position[3][0] = 0;
      position[3][1] = 4;
      state = 0;
        
    }
    else
    {
     // box_n[0][4].boxDiv.style.backgroundColor =  boxColor[color];
      box_n[0][4].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][5].boxDiv.style.backgroundColor = boxColor[color];
      box_n[0][6].boxDiv.style.backgroundColor = boxColor[color];
      position[0][0] = -1; 
      position[0][1] = 4;
      position[1][0] = 0;
      position[1][1] = 4;
      position[2][0] = 0;
      position[2][1] = 5;
      position[3][0] = 0;
      position[3][1] = 6;
      state = 0;
    }
    
  
}

void rotate()
{
    int flag = 0;
    int temp1,temp2,i;
    if(type == 0)
    {
      if(state == 0)
      {
        if(position[2][0] + 1 < 14)
        {
          if(box_n[position[2][0]+1][position[2][1]]!='white')
          {
            box_n[position[2][0]+1][position[2][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
            position[1][0] = position[2][0];
            position[1][1] = position[2][1];
            temp1 = position[2][0];
            temp2 = position[2][1];
            position[2][0] = position[3][0];
            position[2][1] = position[3][1];
            position[3][0] = temp1+1;
            position[3][1] = temp2;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 1;
          }
        
        }
      }
      else if(state == 1)
      {
        if(position[1][1]-1 >= 0)
        {
          if(box_n[position[1][0]][position[1][1]-1].boxDiv.style.backgroundColor=='white')
          {
            box_n[position[1][0]][position[1][1]-1].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
            position[0][0] = position[1][0];
            position[0][1] = position[1][1]-1;
            state = 2;
          }
        }
      }
      else if(state == 2)
      {
        if(position[1][0]-1 >=0)
        {
          if(box_n[position[1][0]-1][position[1][1]].boxDiv.style.backgroundColor=='white')
          {
            box_n[position[1][0]-1][position[1][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[1][0]][position[1][1]+1].boxDiv.style.backgroundColor = 'white';
            temp1 = position[1][0];
            temp2 = position[1][1];
            position[0][0] = temp1 - 1;
            position[0][1] = temp2;
            position[1][1] = temp2 - 1;
            position[2][0] = temp1;
            position[2][1] = temp2;
            position[3][0] = temp1 + 1;
            position[3][1] = temp2;            
            state = 3;
          }
        }
      }
      else if(state == 3)
      {
        if(position[2][1]+1 < 10)
        {
          if(box_n[position[2][0]][position[2][1]+1].boxDiv.style.backgroundColor =='white')
          {
            box_n[position[2][0]][position[2][1]+1].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = 'white';
            position[3][0] = position[2][0];
            position[3][1] = position[2][1] + 1;
            state = 0;
          }
        }
      }
    }
    if(type == 1)
    {
      if(state == 0)
      {
         if(position[2][0]-2 < 0||position[2][0] + 1 > 14)
           flag = 1;
         if(flag == 0)
         {
           if(box_n[position[2][0]-2][position[2][1]].boxDiv.style.backgroundColor == 'white'
               ||box_n[position[2][0]-1][position[2][1]].boxDiv.style.backgroundColor == 'white'
               ||box_n[position[2][0]+1][position[2][1]].boxDiv.style.backgroundColor == 'white'){
             box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
             box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
             box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = 'white';
             position[0][0]  = position[2][0] - 2;
             position[0][1]  = position[2][1];
             position[1][0]  = position[2][0] - 1;
             position[1][1]  = position[2][1];
             position[3][0]  = position[2][0] + 1;
             position[3][1]  = position[2][1];
             box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
             box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = boxColor[color];
             box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
             state = 1;
             
           }
             
         }
       }
      else if(state == 1)
      {
        if(position[2][1]-2 < 0||position[2][1] + 1 > 10)
           flag = 1;
        if(flag == 0)
        {
          if(box_n[position[2][0]][position[2][1]-2].boxDiv.style.backgroundColor == 'white'
             ||box_n[position[2][0]][position[2][1]-1].boxDiv.style.backgroundColor == 'white'
             ||box_n[position[2][0]][position[2][1]+1].boxDiv.style.backgroundColor == 'white')
          {
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = 'white';
            position[0][0]  = position[2][0];
            position[0][1]  = position[2][1] - 2;
            position[1][0]  = position[2][0];
            position[1][1]  = position[2][1] - 1;
            position[3][0]  = position[2][0];
            position[3][1]  = position[2][1] + 1;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 0;
           
          }
        }
      }
    }
    if(type == 3)
    {
      if(state == 0)
      {
        if(position[2][0]-1 > 0&&position[2][1] + 1 < 10)
        {
          if(box_n[position[2][0]-1][position[2][1]].boxDiv.style.backgroundColor == 'white'&&
             box_n[position[2][0]-1][position[2][1]+1].boxDiv.style.backgroundColor == 'white' )
          {
            box_n[position[2][0]-1][position[2][1]-1].boxDiv.style.backgroundColor = 'white';
            box_n[position[2][0]+1][position[2][1]].boxDiv.style.backgroundColor = 'white';
            temp1 = position[2][0];
            temp2 = position[2][1];
            position[0][0] = temp1 - 1;
            position[0][1] = temp2;
            position[1][0] = temp1 - 1;
            position[1][1] = temp2 + 1;
            position[2][0] = temp1;
            position[2][1] = temp2 - 1;
            position[3][0] = temp1;
            position[3][1] = temp2;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 1;
          }
        }
      }
      else if(state == 1)
      {
        if(position[3][0]+1 < 15&&position[3][0] - 1 > 0)
        {
          if(box_n[position[3][0]+1][position[3][1]].boxDiv.style.backgroundColor == 'white'&&
             box_n[position[3][0]-1][position[3][0]-1].boxDiv.style.backgroundColor == 'white')
          {
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
            temp1 = position[3][0];
            temp2 = position[3][1];
            position[0][0] = temp1 - 1;
            position[0][1] = temp2 - 1;
            position[1][0] = temp1;
            position[1][1] = temp2 - 1;
            position[2][0] = temp1;
            position[2][1] = temp2;
            position[3][0] = temp1 + 1;
            position[3][1] = temp2;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 0;
          }
        } 
      }
    }
    if(type == 4)
    {
      if(state == 0)
      {
        if(position[0][1]+1 < 10&&position[0][0]+2<15)
        {
          if(box_n[position[0][0]][position[0][1]+1].boxDiv.style.backgroundColor == 'white'&&
            box_n[position[1][0]+1][position[1][1]].boxDiv.style.backgroundColor == 'white')
          {
            box_n[position[2][0]][position[2][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = 'white';
            temp1 = position[0][0];
            temp2 = position[0][1];
            position[1][0] = temp1;
            position[1][1] = temp2+1;
            position[2][0] = temp1+1;
            position[2][1] = temp2;
            position[3][0] = temp1+2;
            position[3][1] = temp2;
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 1;
          }
        }
      }
      else if(state == 1)
      {
        if(position[0][1]-1 >=0)
        {
          if(box_n[position[0][0]][position[0][1]-1].boxDiv.style.backgroundColor == 'white'&&
            box_n[position[1][0]+1][position[1][1]].boxDiv.style.backgroundColor == 'white')
          {
            box_n[position[2][0]][position[2][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = 'white';
            temp1 = position[0][0];
            temp2 = position[0][1];
            position[0][0] = temp1;
            position[0][1] = temp2-1;
            position[1][0] = temp1;
            position[1][1] = temp2;
            position[2][0] = temp1;
            position[2][1] = temp2+1;
            position[3][0] = temp1+1;
            position[3][1] = temp2+1;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 2;
          }
        }
      }
      else if(state == 2)
      {
        if(position[0][0]-1 >=0)
        {
          if(box_n[position[3][0]][position[3][1]-1].boxDiv.style.backgroundColor == 'white'&&
            box_n[position[2][0]-1][position[2][1]].boxDiv.style.backgroundColor == 'white')
          {
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
            box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
            temp1 = position[3][0];
            temp2 = position[3][1];
            position[0][0] = temp1-2;
            position[0][1] = temp2;
            position[1][0] = temp1-1;
            position[1][1] = temp2;
            position[2][0] = temp1;
            position[2][1] = temp2-1;
            box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
            box_n[position[2][0]][position[2][1]].boxDiv.style.backgroundColor = boxColor[color];
            state = 3;
          }
        }
      }
      else if(state == 3)
      {
          if(position[2][1] + 1 < 10)
          {
            if(box_n[position[2][0]-1][position[2][1]].boxDiv.style.backgroundColor == 'white'&&
              box_n[position[3][0]][position[3][1]+1].boxDiv.style.backgroundColor == 'white')
            {
              box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = 'white';
              box_n[position[1][0]][position[1][1]].boxDiv.style.backgroundColor = 'white';
              temp1 = position[2][0];
              temp2 = position[2][1];
              position[0][0] = temp1-1;
              position[0][1] = temp2;
              position[1][0] = temp1;
              position[1][1] = temp2;
              position[2][0] = temp1;
              position[2][1] = temp2+1;
              position[3][0] = temp1;
              position[3][1] = temp2+2;
              box_n[position[0][0]][position[0][1]].boxDiv.style.backgroundColor = boxColor[color];
              box_n[position[3][0]][position[3][1]].boxDiv.style.backgroundColor = boxColor[color];
              state = 0;
            }
          }
      }
  }
}
      
    




String px(num number) {
    return "${number}px";
  }