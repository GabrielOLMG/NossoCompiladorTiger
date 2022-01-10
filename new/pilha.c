#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node{
 char* id;
 int registro;
 struct Node *prox;
};
typedef struct Node node;

int tam;

void inicia(node *PILHA);
node* push(node *PILHA,node *novo);
node *pop(node *PILHA);

void inicia(node *PILHA){
  PILHA = NULL;
  //PILHA->prox = NULL;
  tam=0;
}

node *aloca(char*id_, int registro_){
  node *novo=(node *) malloc(sizeof(node));
  char* str = malloc(strlen(id_)+1);
  strcpy(str,id_);
  novo->id = str;
  novo->registro = registro_;
  novo->prox = NULL;
  return novo;
}


node* push(node *PILHA,node *novo){
 if(PILHA==NULL){
    PILHA = novo;
    return PILHA;
 }else{
    node *tmp = PILHA;
    while(tmp->prox != NULL){
      tmp = tmp->prox;
    }
    tmp->prox = novo;
    return PILHA;
 }
 tam++;
}


node *pop(node *PILHA){
  if(PILHA == NULL) return NULL;
  if(PILHA->prox == NULL){
    node* a = PILHA;
    tam--;
    PILHA = NULL;
    return PILHA;
  }if(PILHA->prox->prox == NULL){
    node* a = PILHA->prox;
    PILHA->prox = NULL;
    tam--;
    return a;
  }else{
    node*act = PILHA->prox;
    return pop(act);
  }
}

node *search(node* PILHA, char*id){
  if(strcmp(PILHA->id,id)==0){
    return PILHA;
  }

  
  if(PILHA->prox == NULL){
    //Não achou na pilha
    return NULL;
  }else{
    node *act = PILHA->prox;
    return search(act,id);
  }
  
}
