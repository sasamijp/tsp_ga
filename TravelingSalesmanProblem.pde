
class TravelingSalesmanProblem {
  
  int generation_length = 300;
  int generation_count;
  int mutation_rate = 5;
  int elite_length;
  int np1, np2;
  int cities_length = cities_count;
  PVector map_range = new PVector(1000,1000);
  PVector[] cities = new PVector[cities_length];
  int road_length = calcBit(cities_length);
  Road[] roads = new Road[road_length];
  //PVector[][] roads = new PVector[road_length][2];
  RoadMap[] genes = new RoadMap[generation_length];
  
  TravelingSalesmanProblem(){
    generation_count = 1;
    elite_length = 1;
    setCitiesPosition();
    int c =0;
    for(int i=0;i<cities_length-1;i++){
      for(int l=i+1;l<cities_length;l++){
        roads[c] = new Road(cities[i], cities[l]);
        //roads[c][0] = cities[i];
        //roads[c][1] = cities[l];
        c++;
      }
    }
    //for(int i=0;i<road_length;i++){
    //  print((roads[i][0]));
    //  println((roads[i][1]));
    //}
    
  }
  
  void setCitiesPosition(){
    for(int i=0;i<cities_length;i++)
      cities[i] = new PVector(int(random(map_range.x)),int(random(map_range.y)));
  }
  
  int calcBit(int n){
    return n * (n-1) / 2; 
  }
  
  RoadMapChildren breed(RoadMap a, RoadMap b){
    return a.breed(b);
  }
  
  int exec(){
    for(int i=0;i<generation_length;i++)
      genes[i] = new RoadMap(road_length,mutation_rate);
      
    if(true) return 0;
    while(generation_count < 1000){
       
      dump();
      
      //if(true) return 0;
      nextGen();
      eval();
      sort();
      delay(20);
    }
    dump();
    return generation_count;
  } 
  
  void draw(){
      //dump();
      stroke(0,0,255);
      
      
      nextGen();
      eval();
      sort();
      
      for(int i=0;i<cities_count;i++)
      { 
        
        
        fill(255,0,0);
        /*
        for(int l=0;l<6;l++)
        {
          line(genes[l*10].roads[i].city_a.x+(200*l),  genes[l*10].roads[i].city_a.y,  genes[l*10].roads[i].city_b.x+(200*l),  genes[l*10].roads[i].city_b.y);
          ellipse(genes[0].roads[i].city_a.x+(200*l), genes[0].roads[i].city_a.y, 10,10);
        }
        for(int l=0;l<6;l++)
        {
          line(genes[(l+6)*10].roads[i].city_a.x+(200*l),  genes[(l+6)*10].roads[i].city_a.y + 200,  genes[(l+6)*10].roads[i].city_b.x+(200*l),  genes[(l+6)*10].roads[i].city_b.y+ 200);
          ellipse(genes[0].roads[i].city_a.x+(200*l), genes[0].roads[i].city_a.y+200, 10,10);
        }
        for(int l=0;l<6;l++)
        {
          line(genes[(l+6*2)*10].roads[i].city_a.x+(200*l),  genes[(l+6*2)*10].roads[i].city_a.y + 400,  genes[(l+6*2)*10].roads[i].city_b.x+(200*l),  genes[(l+6*2)*10].roads[i].city_b.y+ 400);
          ellipse(genes[0].roads[i].city_a.x+(200*l), genes[0].roads[i].city_a.y+400, 10,10);
        }
        for(int l=0;l<6;l++)
        {
          line(genes[(l+6*3)*10].roads[i].city_a.x+(200*l),  genes[(l+6*3)*10].roads[i].city_a.y + 600,  genes[(l+6*3)*10].roads[i].city_b.x+(200*l),  genes[(l+6*3)*10].roads[i].city_b.y+ 600);
          ellipse(genes[0].roads[i].city_a.x+(200*l), genes[0].roads[i].city_a.y+600, 10,10);
        }
        for(int l=0;l<6;l++)
        {
          line(genes[(l+6*4)*10].roads[i].city_a.x+(200*l),  genes[(l+6*4)*10].roads[i].city_a.y + 800,  genes[(l+6*4)*10].roads[i].city_b.x+(200*l),  genes[(l+6*4)*10].roads[i].city_b.y+ 800);
          ellipse(genes[0].roads[i].city_a.x+(200*l), genes[0].roads[i].city_a.y+800, 10,10);
        }
        */
        
        line(genes[0].roads[i].city_a.x,genes[0].roads[i].city_a.y,genes[0].roads[i].city_b.x,genes[0].roads[i].city_b.y);
        //line(genes[generation_length-1].roads[i].city_a.x,genes[generation_length-1].roads[i].city_a.y,genes[generation_length-1].roads[i].city_b.x,genes[generation_length-1].roads[i].city_b.y);
        
        ellipse(genes[0].roads[i].city_a.x, genes[0].roads[i].city_a.y, 10,10);
      }
      text("generation : "+str(generation_count) ,10,10);
  }
  
  void sort(){
    Arrays.sort(genes);
  }
  
  void eval(){
    for(int i=0;i<generation_length;i++)
      genes[i].eval();
  }
  
  void selection(){
    //genes[generation_length-1] = genes[0];
    sort();
    
    
  }

  void nextGen(){
    generation_count++;
    
    
    
    
    if(generation_count == 3000)
      exit();
    selection();
    RoadMapChildren childs;
    int c = elite_length;
    for(int i=elite_length ; i < (((generation_length-elite_length)/2) + elite_length) ; i++){
      childs = breed(genes[c],genes[c+1]);
      genes[c] = childs.a;
      genes[c+1] = childs.b;
      //genes[c] = breed(genes[i],genes[i+1]);
      //genes[c+1] = breed(genes[i+1], genes[i]);
      c += 2;
    }
  }
  
  void dump(){
    
    println("generation : " + str(generation_count));
    for(int i=0;i<generation_length;i++){
    //  genes[i].toBit();
      println(" score : " + str(genes[i].getScore()));
    }
  }

}