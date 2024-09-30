import processing.video.*;  // Importa a biblioteca para captura de vídeo

Capture video;  // Variável para armazenar a captura de vídeo

void setup () {
  // Configura uma tela de 640x480 com renderização P3D para capacidades 3D
  size(640, 480, P3D);
  
  // Inicializa a captura de vídeo com resolução 640x480 e taxa de 30 frames por segundo
  video = new Capture(this, 640, 480, 30);
  
  // Inicia a captura de vídeo
  video.start();
}

// Evento que é chamado sempre que há um novo frame disponível na captura
void captureEvent(Capture video) {
  // Lê o próximo frame de vídeo
  video.read();
}

void draw() {
  // Define o fundo como preto
  background(0);
  
  // Carrega os pixels do vídeo para manipulá-los
  video.loadPixels();
  
  // Define a cor de preenchimento como branco
  fill(255);
  
  // Remove as bordas dos objetos
  noStroke();
  
  // Desenha o vídeo capturado na tela nas coordenadas (0, 0)
  image(video, 0, 0);
  
  // Aplica uma rotação no eixo Y, mas aqui o ângulo de rotação é fixo (0)
  rotateY(radians(0));
  
  // Define o número de tiles (azulejos) na grade
  float tiles = 100;
  
  // Calcula o tamanho de cada tile com base na largura da tela e no número de tiles
  float tileSize = width / tiles;
  
  // Loop que percorre todos os tiles nos eixos X e Y
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      
      // Obtém a cor do pixel na posição (x, y) do vídeo
      color c = video.get(int(x * tileSize), int(y * tileSize));
      
      // Mapeia o brilho da cor do pixel para um valor entre 1 e 0
      float b = map(brightness(c), 0, 255, 1, 0);
      
      // Mapeia o brilho para um valor de deslocamento no eixo Z (-100 a 100)
      float z = map(b, 0, 1, -100, 100);
      
      // Salva o estado da matriz antes de modificá-la para cada tile
      push();
      
      // Translada o tile para sua posição no espaço 3D, com deslocamento no eixo Z
      translate(x * tileSize, y * tileSize, z);
      
      // Desenha uma caixa 3D onde o tamanho depende do brilho do pixel
      box(tileSize * b);
      
      // Restaura o estado da matriz para o próximo tile
      pop();
    }
  }
}
