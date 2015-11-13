
class Gene implements Comparable{
  float score;
  String text;
  int answerlength,mutation_rate;
  
  Gene(int answerlength_){
    score = 0.0;
    answerlength = answerlength_;
    mutation_rate = 5;
    //text = RandomStringUtils.randomAlphabetic(answerlength).toUpperCase();
    text = RandomStringUtils.random(answerlength, "01".toCharArray());
  }
  
  Gene(String _text){
    score = 0.0;
    text = _text;
  }
  
  String getText(){
    return text; 
  }
  
  float getScore(){
    return score;
  }
  
  void eval(){
    println("fjhdjfna");
    score = 0.0;
    for(int i=0;i<answerlength;i++){
      print(text.charAt(i) == ga.answer().charAt(i));
      if(ga.answer.charAt(i) == this.text.charAt(i)){
          score += 1.0;
          
          
      }
    }
    //print(text + ga.answer);
    //println(score);
  }

  Gene crossOver(Gene _gene){
    int crosspos = int(random(1,answerlength-1));
    //println(text+"+"+_gene.text+"="+this.text.substring(0,crosspos) + _gene.text.substring(crosspos));
    return new Gene(this.text.substring(0,crosspos) + _gene.text.substring(crosspos));
  }

  void mutation(){
    int pos = int(random(answerlength));
    int pos_ = int(random(answerlength));
    text = text.substring(0,pos)+ RandomStringUtils.random(1, "01".toCharArray())+text.substring(pos+1);
    text = text.substring(0,pos_)+ RandomStringUtils.random(1, "01".toCharArray())+text.substring(pos_+1);
    //text = text.substring(0,pos)+RandomStringUtils.randomAlphabetic(1).toUpperCase()+text.substring(pos+1);
    //text = text.substring(0,pos_)+RandomStringUtils.randomAlphabetic(1).toUpperCase()+text.substring(pos_+1);
  }
  
  Gene breed(Gene _gene){
    Gene child = crossOver(_gene);
    if(int(random(100))<mutation_rate)
      child.mutation();
    return child;
  }
  
  int compareTo(Object o){
    Gene other = (Gene)o;
    if(other.getScore() > score) return 1;
    if(other.getScore() == score) return 0;
    return -1;
  }
  
}

