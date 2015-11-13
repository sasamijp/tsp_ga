
class RoadMap extends Gene{

  int answerlength, mutation_rate;
  Road[] roads = new Road[cities_count];
  //PVector[][] roads = new PVector[cities_count][2];
  
  RoadMap(int answerlength,int mutation_rate){
    super(answerlength);
    text = "";
    genRandomRoadMap();
    toBit();
  }
  
  void genRandomRoadMap(){
    PVector[] cities = new PVector[cities_count];
    IntList map = new IntList();
    for(int i=1;i<cities_count;i++)
      map.append(i);
    map.shuffle();
    map.reverse();
    map.append(0);
    map.reverse();
    map.append(0);
    for(int i=0;i<tsp.cities_length;i++)
      cities[i] = tsp.cities[map.get(i)];
  
    for(int i=0;i<tsp.cities_length-1;i++)
      roads[i]= new Road(cities[i],cities[i+1]);
      
    roads[cities_count-1] = new Road(cities[cities_count-1], cities[0]);
    //roads[cities_count-1][0] = cities[tsp.cities_length-1];
    //roads[tsp.cities_length-1][1] = ;
  }
  
  String getChar(){
    String str = "";
    char[] c = new char[cities_count];
    char[] c2 = new char[cities_count];
    for(int i=0;i<cities_count;i++){
      for(int l=0;l<cities_count;l++){
        if(tsp.cities[i].dist(roads[l].city_a) == 0.0)
          c[l] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(i);
      }
      for(int l=0;l<cities_count;l++){
        if(tsp.cities[i].dist(roads[l].city_b) == 0.0)
          c2[l] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(i);
      }
    }
    for(int i=0;i<cities_count;i++)
      str += str(c[i]) + str(c2[i]);
    return str;
  }
  
  
  void toBit(){
    text = "";
    boolean flag;
    for(int i=0;i<tsp.road_length;i++){
      flag = false;
      for(int l=0;l<tsp.cities_length;l++){
        if(tsp.roads[i].isEquals(roads[l])){
        //if(((tsp.roads[i][0] == roads[l][0]) && (tsp.roads[i][1] == roads[l][1])) || ((tsp.roads[i][0] == roads[l][1]) && (tsp.roads[i][1] == roads[l][0])) ){
          flag = true;
          break;
        }
      }
      if(flag){
        text += "1";
      }else{
        text += "0";
      }
    }
  }
  
  int compareTo(Object o){
    RoadMap other = (RoadMap)o;
    if(other.getScore() > score) return -1;
    if(other.getScore() == score) return 0;
    return 1;
  }
  
  void eval(){
    score = 0.0;
    for(int i=0;i<cities_count;i++)
      score += roads[i].dist();
     //score = 1/score;
        //score += tsp.roads[i][0].dist(tsp.roads[i][1]);
  }
  
  void mutation(){
    /*
    int pos = int(random(tsp.road_length));
    int pos_ = int(random(tsp.road_length));
    text = text.substring(0,pos)+ RandomStringUtils.random(1, "01".toCharArray())+text.substring(pos+1);
    text = text.substring(0,pos_)+ RandomStringUtils.random(1, "01".toCharArray())+text.substring(pos_+1);
    //text = text.substring(0,pos)+RandomStringUtils.randomAlphabetic(1).toUpperCase()+text.substring(pos+1);
    //text = text.substring(0,pos_)+RandomStringUtils.randomAlphabetic(1).toUpperCase()+text.substring(pos_+1);
    */
    int i1, i2;
    i1 = int(random(cities_count));
    i2 = int(random(cities_count));
    PVector swap;
    if(i1-1 > i2){
      this.partialReverse(i2, i1);
      swap = this.roads[i2].city_b;
      this.roads[i2].city_b = this.roads[i1].city_a;
      this.roads[i1].city_a = swap;
    }else if(i1 < i2-1){
      this.partialReverse(i1, i2);
      swap = this.roads[i1].city_b;
      this.roads[i1].city_b = this.roads[i2].city_a;
      this.roads[i2].city_a = swap;
    }
    
    
  }
  
  void partialReverse(int start, int end){
    if( start < end - 1){
      Road[] reversed = new Road[cities_count];
      for(int i=0;i<start+1;i++)
        reversed[i] = roads[i];
      for(int i=end;i-1>start;i--)
        reversed[(start+1)+(end-i)] = new Road(roads[i-1].city_b, roads[i-1].city_a);
      for(int i=end;i<cities_count;i++)
        reversed[i] = roads[i];
      this.roads = reversed;
      
    }else if(( start > end ) && (start != 0) && (end != cities_count-1)){
      
      Road[] reversed = new Road[cities_count];
      Road[] tn = new Road[cities_count*3];
      Road[] nn = new Road[cities_count*3];
      tn = (Road[])concat(roads, (Road[])concat(roads, roads));
      end += cities_count;
      int start2 = start+cities_count;
      int end2 = end+cities_count;
      for(int i=0;i<start+1;i++)
        nn[i] = tn[i];
      for(int i=end;i>start;i--)
        nn[start+1+(end-i)] = new Road(tn[i-1].city_b, tn[i-1].city_a);
      for(int i=end;i<start2+1;i++)
        nn[i] = tn[i];
      for(int i=end2;i>start2;i--)
        nn[start2+1+(end2-i)] = new Road(tn[i-1].city_b, tn[i-1].city_a);;
        
      for(int i=cities_count; i<((cities_count)*2) ;i++)
        reversed[i-cities_count] = nn[i];
      
      this.roads = reversed;
    }
  }
  
  boolean isOK(){
    for(int i=0;i<cities_count-1;i++)
      if(roads[i].city_b != roads[i+1].city_a)
        return false;
    return true;
  }
  
  RoadMapChildren crossOver(RoadMap _gene){

    int i1, i2, j1, j2;
    Road swap;
    i2 = j1 = j2 = 100;
    i1 = int(random(cities_count));
    for(int i=0;i<cities_count;i++){
      if(roads[i1].city_a.dist(_gene.roads[i].city_a) == 0.0)
        i2 = i;
      if(roads[i1].city_b.dist(_gene.roads[i].city_a) == 0.0)
        j2 = i;
    }
    for(int l=0;l<cities_count;l++)
      if(_gene.roads[i2].city_b.dist(roads[l].city_a) == 0.0)
        j1 = l;
        
    //print("isOK ... ");
    //println(isOK());

    swap = roads[i1];
    roads[i1] = _gene.roads[i2];
    _gene.roads[i2] = swap;
    
    if(roads[i1].city_b.dist(_gene.roads[i2].city_b) == 0.0){
        //println("returned !! ");
        return new RoadMapChildren(this, _gene);
    }
    /*
    print(getChar());
    print(" - ");
    print(i1);
    print(",");
    println(j1);
    */
    this.partialReverse(i1, j1);
    //println(getChar());
    
    
    _gene.partialReverse(i2, j2);
    
    i1 = j1;
    i2 = j2;
    
    while(true){
      for(int i=0;i<cities_count;i++){
        if(_gene.roads[i2].city_b.dist(roads[i].city_a) == 0.0)
          j1 = i;
        if(roads[i1].city_b.dist(_gene.roads[i].city_a) == 0.0)
          j2 = i;
      }
      
      //delay(10);
      
      swap = roads[i1];
      roads[i1] = _gene.roads[i2];
      _gene.roads[i2] = swap;
      
      if(roads[i1].city_b.dist(_gene.roads[i2].city_b) == 0.0)
        break;
      /*
      print("reverse start");
      print(i2);
      print(",");
      println(j2);
      println(_gene.getChar());
      */
      this.partialReverse(i1, j1);
      
      _gene.partialReverse(i2, j2);
      /*
      println(_gene.getChar());
      println("reverse end ");
      */
      i1 = j1;
      i2 = j2;
    
    }
    //println(isOK());
    return new RoadMapChildren(this, _gene);
  }

  RoadMapChildren breed(RoadMap _gene){
    mutation_rate = 1;
    RoadMapChildren child;
    //if(int(random(2)) == 1 )
      child = crossOver(_gene);
    //else
    //  child = new RoadMapChildren(this, _gene);

    if( int(random(30000)) < mutation_rate)
      child.a.mutation();
    //if(int(random(1000)) < mutation_rate)
    //  child.b.mutation();
    return child;
  }

}