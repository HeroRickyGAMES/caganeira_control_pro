bool Barro(int x) {
  return (x >= 0) && (x <= 399);
}

bool Folha(int x) {
  return (x >= 400) && (x <= 799);
}

bool Concreto(int x) {
  return (x >= 800) && (x <= 1199);
}

bool Ferro(int x) {
  return (x >= 1200) && (x <= 1599);
}

bool Bronze(int x) {
  return (x >= 1600) && (x <= 1999);
}

bool Prata(int x) {
  return (x >= 2000) && (x <= 2399);
}

bool Aco(int x) {
  return (x >= 2400) && (x <= 2799);
}

bool Ouro(int x) {
  return (x >= 2800) && (x <= 3199);
}

bool Platina(int x) {
  return (x >= 3200) && (x <= 3599);
}

bool Mestre(int x) {
  return (x >= 3600) && (x <= 3999);
}

bool GM(int x) {
  return (x >= 4000) && (x <= 4399);
}

bool Desafiante(int x) {
  return (x >= 4400) && (x <= 4799);
}

bool DesafianteDaMerda(int x) {
  return (x >= 4800);
}