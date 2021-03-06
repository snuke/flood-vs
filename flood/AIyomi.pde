class AIyomi extends AI {
  int[][] get_dist(int[][] d, int sx, int sy){
    int i,j,k;
    int INF = (1<<29);
    int dist[][] = new int[50][50];
    for(i=0;i<50;i++) for(j=0;j<50;j++) dist[i][j] = INF;
    dist[sx][sy] = 0; 
    while(true){
      boolean updated = false;
      for(i=0;i<50;i++) for(j=0;j<50;j++) for(k=0;k<4;k++){
        int i2 = i + dx[k], j2 = j + dy[k];
        if(i2 >= 0 && i2 < 50 && j2 >= 0 && j2 < 50){
          int nd = dist[i][j];
          if(d[i][j] != d[i2][j2]) nd++;
          if (dist[i2][j2] > nd) {
            dist[i2][j2] = nd;
            updated = true;
          } 
        }
      }
      if (!updated) break;
    }
    return dist;
  }
  double score(int[][] d){
    int dist0[][] = get_dist(d, 0, 0);
    int dist1[][] = get_dist(d, 49, 49);
    double ans = 0.0;
    int i,j;
    for(i=0;i<50;i++) for(j=0;j<50;j++) ans += dist1[i][j] / (double)(dist0[i][j] + dist1[i][j]) - 0.5;
    return ans;
  }
  double val(int dep, int[][] d, int player) {
    if (dep == 0) {
      double sc = score(d);
      if (player == 1) sc = -sc;
      return sc;
    }
    double res = -100000;
    for (int c = 0; c < 5; c++) {
      if (!valid(d,c)) continue;
      int[][] now = sim(d,c,player);
      double sc = val(dep-1,now,player^1);
      if (sc > res) res = sc;
    }
    return -res;
  }
  int sol(int[][] d, int player) {
    double best = -100000;
    int bc = 0;
    for (int c = 0; c < 5; c++) {
      if (!valid(d,c)) continue;
      int[][] now = sim(d,c,player);
      double sc = val(3,now,player^1);
      if (player == 1) sc = -sc;
      if (sc > best) {
        best = sc;
        bc = c;
      }
    }
    return bc;
  }
}


 

