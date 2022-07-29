#include <stdio.h>
#include <stdbool.h>

#define TAM 10


typedef struct tipoNumero {
    int numero;
}tiponumero;

typedef struct Numeros {
    tiponumero itens[TAM];
    int comeco;
    int final;
}numeros;

void iniciar(numeros *f);
bool vazia(numeros *f);
bool cheia(numeros *f);
void enfileirar(numeros *f, int n);
void desenfileirar(numeros *f);
void imprimir(numeros *f);

int main(int argc, char const *argv[])
{
    numeros fila;
    iniciar(&fila);
    
    desenfileirar(&fila);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 2);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 4);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 20);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 34);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 8);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 90);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 12);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 12);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 12);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    enfileirar(&fila, 12);
    enfileirar(&fila, 12);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);

    enfileirar(&fila, 7);
    imprimir(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    
    desenfileirar(&fila);
    printf("\nComeço: %d, Final: %d\n", fila.comeco, fila.final);
    imprimir(&fila);

    return 0;
}

void iniciar(numeros *f) {
    f->comeco = 1;
    f->final = f->comeco;

    //f->final = f->comeco = 0;
}

bool vazia(numeros *f) {
    if (f->final == f->comeco) {
        return true;
    }
    
    return false;

    //return f->final == f->comeco;
}

bool cheia(numeros *f) {
    if (f->final % TAM + 1 == f->comeco) {
        return true;
    }

    return false;

    //return f->final % TAM + 1 == f->comeco;
}

void enfileirar(numeros *f, int n) {
    if (cheia(f)) {
        printf("\n\nFILA CHEIA!!\n\n");
    } else {
        f->itens[f->final-1].numero = n;
        f->final = f->final % TAM + 1;
    }
}

void desenfileirar(numeros *f) {
    if (vazia(f)) {
        printf("\n\nFILA VAZIA!!\n\n");
    } else {
        f->comeco = f->comeco % TAM + 1;
    }
    
}

void imprimir(numeros *f) {
    int ini, fin;
    if (!vazia(f)) {
        ini = f->comeco < f->final ? f->comeco : f->final;
        fin = f->comeco < f->final ? f->final : f->comeco;
        printf("\n==============\n");
        for (int i = ini; i < fin ; i++) {
            printf("%d\n", f->itens[i].numero);
        }   
        printf("==============\n");
    } else {
        printf("\nFila vazia!\n");
    } 
}