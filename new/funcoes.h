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

Exp mk_tc(ties_cond tc, Exp left, Exp middle, Exp right){
  Exp e = (Exp)malloc(sizeof(struct _exp));
  e->tag = TC;
  e->ties_cond.tc = tc;
  e->ties_cond.left = left;
  e->ties_cond.middle = middle;
  e->ties_cond.right = right;
  return e;
}

Exp mk_io(io_ io, Exp value){
  Exp e = (Exp)malloc(sizeof(struct _exp));
  e->tag = IO;
  e->io_.io = io;
  e->io_.value = value;
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
    case NE:
      printf("NE ");
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
      printf("NAO IMPLEMENTADO ");
      break;
  }
}

void printaEnumTc(ties_cond tc){
  switch (tc){
  case IF_:
    printf("IF ");    
    break; 
  case IF_ELSE:
    printf("IF ELSE ");
    break;
  case WHILE_DO:
    printf("WHILE DO ");
    break;
  default:
    printf("NAO IMPLEMENTADO ");
    break;
  }
}

void printaEnumIo(io_ io){
  switch (io){
  case PRINTI_:
    printf("PRINTI");
    break;
  case SCANI_:
    printf("SCANI");
    break;
  default:
    printf("NAO IMPLEMENTADO ");
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
    case TC:
      printf("(");
      printaEnumTc(e->ties_cond.tc);
      printaExp(e->ties_cond.left);
      printf(" ");
      printaExp(e->ties_cond.middle);
      if (e->ties_cond.right != NULL){
        printf(" ");
        printaExp(e->ties_cond.right);
      }
      printf(")");
      break;
    case IO:
      printf("(");
      printaEnumIo(e->io_.io);
      if (e->io_.value != NULL){
        printf(" ");
        printaExp(e->io_.value);
      }
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








