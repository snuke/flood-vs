
final static int N = 50, C = 5;
final static int[] di = {0,-1,0,1};
final static int[] dj = {-1,0,1,0};
int[][] d = new int[N][N];
int[][] blng = new int[N][N];
int[] sz = new int[N];
color[] col = new color[C];
int turn, player;
int wait;
AI[] ai = new AI[2];


void setup() {
  size(780,540);
  col[0] = color(0,0,255);
  col[1] = color(0,180,255);
  col[2] = color(0,255,255);
  col[3] = color(200,100,0);
  col[4] = color(0,128,0);
  //////////////////////////// select AI ////////////////////////
  // weak | AI < AIfresh < AIgreedy < AIvoronoi| strong
  ai[0] = new Human();
  ai[1] = new AIgreedy();
  ///////////////////////////////////////////////////////////////
  Init();
}

int rand(int x) { return (int)(random(x));}
void Init() {
  for (int i = 0; i < N; i++) for(int j = 0; j < N; j++) {
    d[i][j] = rand(C);
    blng[i][j] = -1;
  }
  player = 0; sz[0] = count(0,0);
  player = 1; sz[1] = count(N-1,N-1);
  turn = 0; player = 0;
  wait = 0;
}

void draw() {
  update();
  background(255);
  fill(0);
  text("Turn : "+(turn+1),360,14);
  text("Size : "+sz[0],140,14);
  text("Size : "+sz[1],600,14);
  for (int i = 0; i < N; i++) for(int j = 0; j < N; j++) {
    fill(col[d[i][j]]);
    rect(140+j*10,20+i*10,10,10);
    if (blng[i][j] != -1) {
      if (blng[i][j] == 0) fill(color(200,0,0));
      if (blng[i][j] == 1) fill(color(0,128,0));
      stroke(255);
      ellipse(140+j*10+5,20+i*10+5,4,4);
      stroke(0);
    }
  }
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < C; i++) {
      if (turn%2 == j && d[0][0] != i && d[N-1][N-1] != i) {
        fill(col[i]);
      } else fill(color(100));
      rect(20+j*640,20+i*100,100,100);
    }
  }
}

void dfs(int i, int j, int c) {
  int pre = d[i][j];
  d[i][j] = c;
  for (int v = 0; v < 4; v++) {
    int ni = i+di[v], nj = j+dj[v];
    if (ni<0||nj<0||ni>=N||nj>=N) continue;
    if (d[ni][nj] == pre) dfs(ni,nj,c);
  }
}
int count(int i, int j) {
  blng[i][j] = player;
  int res = 1;
  for (int v = 0; v < 4; v++) {
    int ni = i+di[v], nj = j+dj[v];
    if (ni<0||nj<0||ni>=N||nj>=N) continue;
    if (d[ni][nj] == d[i][j] && blng[ni][nj] == -1) res += count(ni,nj);
  }
  return res;
}
boolean select(int c) {
  if (c == -1 || c == d[0][0] || c == d[N-1][N-1]) return false;
  dfs(player*(N-1), player*(N-1), c);
  for (int i = 0; i < N; i++) for(int j = 0; j < N; j++) {
    if (blng[i][j] == player) blng[i][j] = -1;
  }
  sz[player] = count(player*(N-1),player*(N-1));
  turn++; player ^= 1;
  return true;
}
void mouseClicked() {
  int pos = -1;
  int mx = mouseX, my = mouseY;
  int lx = 20+player*640;
  if (mx >= lx && mx < lx+100 && my >= 20 && my < 20+100*C) {
    pos = (my-20)/100;
  } else return;
  ai[player].setc(pos);
}

void update() {
  wait++;
  if (wait < 5) return;
  wait = 0;
  select(ai[player].sol(d,player));
}







