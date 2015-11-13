
class Road{
  PVector city_a, city_b;
  Road(PVector _a, PVector _b){
    city_a = _a;
    city_b = _b;
  }
  
  float dist(){
    return city_a.dist(city_b);
  }
  
  Road exchange(){
    PVector swap;
    swap = city_a;
    this.city_a = city_b;
    this.city_b = swap;
    return this;
  }
  
  boolean isEquals(Road other){
    return ((city_a == other.city_a && city_b == other.city_b) || (city_a == other.city_b && city_b == other.city_a));
  }
}