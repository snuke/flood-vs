class AI {
  final int[] dx = {0,-1,0,1};
  final int[] dy = {-1,0,1,0};
  AI(){}
  int rand(int x) { return (int)(random(x));}
  boolean valid(int[][] d, int c) {
    if (c == d[0][0] || c == d[N-1][N-1]) return false;
    return true;
  }
  void dfs(int[][] d, int i, int j, int c) {
    int pre = d[i][j];
    d[i][j] = c;
    for (int v = 0; v < 4; v++) {
      int ni = i+dx[v], nj = j+dy[v];
      if (ni<0||nj<0||ni>=N||nj>=N) continue;
      if (d[ni][nj] == pre) dfs(d,ni,nj,c);
    }
  }
  int[][] sim(int[][] d, int c, int player) {
    int[][] res = new int[50][50];
    for (int i = 0; i < 50; i++) for (int j = 0; j < 50; j++) res[i][j] = d[i][j];
    dfs(res, player*(N-1), player*(N-1), c);
    return res;
  }
  int sol(int[][] d, int player) {
    while (true) {
      int c = rand(5);
      if (valid(d,c)) return c;
    }
  }
  void setc(int c) {}
}
