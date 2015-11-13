
import org.apache.commons.lang3.reflect.*;
import org.apache.commons.lang3.builder.*;
import org.apache.commons.lang3.math.*;
import org.apache.commons.lang3.text.translate.*;
import org.apache.commons.lang3.text.*;
import org.apache.commons.lang3.concurrent.*;
import org.apache.commons.lang3.tuple.*;
import org.apache.commons.lang3.exception.*;
import org.apache.commons.lang3.mutable.*;
import org.apache.commons.lang3.*;
import org.apache.commons.lang3.time.*;
import org.apache.commons.lang3.event.*;

import java.util.Arrays;

int sum;
GeneticAlgorithm ga;
TravelingSalesmanProblem tsp;
int cities_count = 60;

void setup(){
  //sum = 0;
  //for(int i=0;i<100;i++)
  //  sum += test();
  //println(sum/100);
  //test();
  frameRate(30);
  
  
  size(1000,1000);
  
  //size(int(tsp.map_range.x), int(tsp.map_range.y));
  //size(int(tsp.map_range.x)*6, int(tsp.map_range.y)*5);
  tsp = new TravelingSalesmanProblem();
  test_();
  
}

void draw(){
  background(255);
  stroke(100);
  tsp.draw();
  //for(int i=0;i<tsp.road_length;i++){
    //line(tsp.roads[i].city_a.x,tsp.roads[i].city_a.y,tsp.roads[i].city_b.x,tsp.roads[i].city_b.y);
      //line(tsp.roads[i][0].x,tsp.roads[i][0].y,tsp.roads[i][1].x,tsp.roads[i][1].y);
  //}
  //tsp.draw();
  //saveFrame();
}

void test_(){
  tsp.exec();
}

int test(){
  ga = new GeneticAlgorithm();
  return ga.exec();
}