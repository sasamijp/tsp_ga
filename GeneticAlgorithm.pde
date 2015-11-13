
class GeneticAlgorithm {
  int generation_length = 40;
  int generation_count;
  int mutation_rate;
  int elite_length;
  String answer;
  Gene[] genes = new Gene[generation_length];

  GeneticAlgorithm(){
    generation_count = 1;
    answer = "1111111111111111";
    mutation_rate = 5;
    elite_length = 1;
    for(int i=0;i<generation_length;i++)
      genes[i] = new Gene(answer.length());
  }

  String answer(){
    return answer;
  }

  void dump(){
    println("generation : " + str(generation_count));
    for(int i=0;i<generation_length;i++)
      println(genes[i].getText() + " score : " + str(genes[i].score));
  }

  void eval(){
    for(int i=0;i<generation_length;i++){
      genes[i].eval();
      //println("called");
    }
  }

  void sort(){
    Arrays.sort(genes);
  }

  int getTopScore(){
    return int(genes[0].getScore());
  }

  int getMinScore(){
    return int(genes[generation_length-1].getScore());
  }

  Gene breed(Gene a, Gene b){
    return a.breed(b);
  }

  void nextGen(){
    generation_count++;
    selection();
    int c = elite_length;
    for(int i=elite_length;i<((generation_length-elite_length)/2)+elite_length;i++){
      genes[c] = breed(genes[i],genes[i+1]);
      genes[c+1] = breed(genes[i+1], genes[i]);
      c += 2;
    }
  }
  
  void selection(){
    //genes[generation_length-1] = genes[0];
    sort();
  }

  int exec(){
    while(getTopScore() != answer.length()){
      
      nextGen();
      this.eval();
      sort();
      
      dump();
      
      delay(50);
    }
    dump();
    return generation_count;
  } 
  
}

