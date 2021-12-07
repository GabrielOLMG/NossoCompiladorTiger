Exp mk_num(int v){
  Exp e = (Exp)malloc(sizeof(struct _exp));
  e->tag = NUM;
  e->val = v;
  return e;
}

Exp mk_id(char* txt){
  Exp e = (Exp)malloc(sizeof(struct _exp));
  char* str = malloc(strlen(txt)+1);
  strcpy(str,txt);
  e->tag = ID;
  e->id = str;
  return e;
}

Exp mk_op(operacoes op, Exp e1, Exp e2){
  Exp e = (Exp)malloc(sizeof(struct _exp));
  e->tag = OP;
  e->operacoes.op = op;
  e->operacoes.left = e1;
  e->operacoes.right = e2;
  return e;
}



/*Assert mk_assert(Exp direita, Exp esquerda){
  Assert a = (Assert)malloc(sizeof(struct _assert));
  a->esquerda = esquerda;
  a->direita = direita;
  return a;
}*/



void printaEnumOp(operacoes op){
  switch(op){
    case PLUS:
      printf("PLUS ");
      break;
    case MINUS:
      printf("MINUS ");
      break;
    case TIME:
      printf("TIME ");
      break;
    case DIV:
      printf("DIV ");
      break;
    case MOD:
      printf("MOD ");
      break;
    case GT:
      printf("GT ");
      break;
    case LT:
      printf("LT ");
      break;
    case GE:
      printf("GE ");
      break;
    case LE:
      printf("LE ");
      break;
    case EQ:
      printf("EQ ");
      break;
    case ASSERT:
      printf("ASSERT ");
      break;
    case EXP_SEQ:
      printf("EXP_SEQ ");
      break;
    default:
      printf("<ainda n implementado>");
      break;
  }
}

void printaExp(Exp e){
  switch(e->tag){
    case NUM:
      printf("[NUM %d]", e->val);
      break;
    case ID:
      printf("[ID %s]", e->id);
      break;
    case OP:
      printf("(");
      printaEnumOp(e->operacoes.op);
      printaExp(e->operacoes.left);
      printf(" ");
      printaExp(e->operacoes.right);
      printf(")");
      break;
    default:
      printf("erro \n");
      break;
  }
}

/*void printaAssert(Assert a){
  printf("(ASSERT ");
  printaExp(a->direita);
  printf(" ");
  printaExp(a->esquerda);
  printf(")");
}*/








