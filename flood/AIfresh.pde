class AIfresh extends AI {
  int[] p = new int[5];
  int turn = 1;
  int sol(int[][] d, int player) {
    int best = 100000;
    int bc = 0;
    for (int c = 0; c < 5; c++) {
      if (!valid(d,c)) continue;
      int sc = p[c];
      if (sc < best) {
        best = sc;
        bc = c;
      }
    }
    p[bc] = turn; turn++;
    return bc;
  }
}
