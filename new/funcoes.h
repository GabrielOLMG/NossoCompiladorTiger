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
    default:
      printf("ainda n implementado");
      break;
  }
}

void printaExp(Exp e){
  switch(e->tag){
    case NUM:
      printf("NUM %d ", e->val);
      break;
    case OP:
      printf("(");
      printaEnumOp(e->operacoes.op);
      printaExp(e->operacoes.left);
      printaExp(e->operacoes.right);
      printf(")");
      break;
    default:
      printf("erro \n");
      break;
  }
}

