class Human extends AI {
  int selected;
  Human() { selected = -1;}
  int sol(int[][] d, int player) {
    if (selected == -1) return -1;
    if (!valid(d,selected)) return -1;
    int res = selected;
    selected = -1;
    return res;
  }
  void setc(int c) { selected = c;}
}


 

