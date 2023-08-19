// André Zanardi Creppe - 11802972
// Programado dentro da IDE CLion

#ifndef PROVA_TOPICOS_VIZINHOS_H
#define PROVA_TOPICOS_VIZINHOS_H


class Vizinhos {
public:
    static void transform(float[20][20], float[20][20]);
    static void test();

private:
    static float center(float[20][20], int, int);
    static float top(float[20][20], int, int);
    static float left(float[20][20], int, int);
    static float right(float[20][20], int, int);
    static float bottom(float[20][20], int, int);
    static void showMatrix(float[20][20]);
};


#endif //PROVA_TOPICOS_VIZINHOS_H
