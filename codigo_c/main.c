#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "User_i.c"
#include "Bike_i.c"
#include "rent_bike_i.c"


int main(int argc, char **argv) {

    int op;
    int op1;
    int op2;
    int health;
    int result;

    rent_bike__INITIALISATION();

    while(true){
        printf("=================BEM VINDO AO RENTBIKE ================\n"); 

        printf("=================MENU BIKE ================\n"); 
        printf("PARA INSERIR UMA BIKE DIGITE 1\n"); 
        printf("PARA EXCLUIR UMA BIKE DIGITE 2\n");  
        printf("PARA RESETAR A SAUDE DE ALGUMA BIKE DIGITE 3\n"); 
        printf("PARA SABER A SAUDE DE ALGUMA BIKE DIGITE 4\n"); 
        printf("PARA PARA INSERIR DANOS A ALGUMA BIKE DIGITE 5\n"); 

        printf("=================MENU USER ================\n"); 
        printf("PARA INSERIR UM USUARIO DIGITE 6\n"); 
        printf("PARA EXCLUIR UMA USUARIO DIGITE 7\n");  
        printf("PARA INSERIR CREDITOS A UM USUARIO DIGITE 8\n"); 
        printf("PARA SABER A QUANTIDADE DE CREDITOS DE UM USUARIO DIGITE 9\n"); 


        printf("=================MENU RENTBIKE ================\n"); 
        printf("PARA ALUGAR UMA BICICLETA DIGITE 10\n"); 
        printf("PARA DEVOLVER UMA BICICLETA DIGITE 11 7\n");  
        printf("PARA AVALIAR UMA BICICLETA DIGITE 12\n"); 
        printf("PARA CRIAR DESCONTO A UMA BICICLETA DIGITE 13\n"); 
        printf("PARA SAIR DIGITE 0\n"); 

        scanf("%d", &op);

        switch( op )
        {
            case 1:
                    printf("Digite o numero da bicicleta que deseja inserir\n");
                    scanf("%d", &op1);

                    Bike__create_bike(op1);
                    break;
            
            case 2:
                    printf("Digite o numero da bicicleta que deseja Excluir\n");
                    scanf("%d", &op1);
                    Bike__delete_bike(op1);
                    break;
            
            case 3:
                    printf("Digite o numero da bicicleta que deseja Resetar a sáude\n");
                    scanf("%d", &op1);
                    Bike__reset_helth(op1);
                    break;
            case 4:
                    printf("Digite o numero da bicicleta que deseja Saber a sáude\n");
                    scanf("%d", &op1);
                    Bike__get_helth(op1, &health);
                    printf("Saude Atual: %d\n", health);
                    break;
            case 5:
                    printf("Digite o numero da bicicleta e o valor do dano que deseja inserir\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    Bike__set_damage(op1,op2);
                    break;
            case 6:
                    printf("Digite o numero do usuario que deseja inserir\n");
                    scanf("%d", &op1);
                    User__create_user(op1);
                    break;
            case 7:
                    printf("Digite o numero do usuario que deseja Excluir\n");
                    scanf("%d", &op1);
                    rent_bike__remove_user(op1);
                    break;
            case 8:
                    printf("Digite o numero do usuario e o a quantidade de creditos que deseja inserir\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    User__add_credit(op1,op2);
                    break;
            case 9:
                    printf("Digite numero do usuario que deseja saber os creditos\n");
                    scanf("%d", &op1);
                    scanf("%d", &result);
                    User__get_credits(op1, &result);
                    break;
            case 10:
                    printf("Digite o numero do usuario e o numero da bicibleta que deseja alugar\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    rent_bike__rentBike(op1,op2);
                    break;
            case 11:
                    printf("Digite o numero do usuario e numero da bicicleta que deseja devolver\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    rent_bike__return_bike(op1,op2);
                    break;
            case 12:
                    printf("Digite o numero da bicicleta e o valor de avaliação\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    rent_bike__evaluate_bike(op1,op2);
                    break;
            case 13:
                    printf("Digite o numero da bicicleta e o valor do desconto\n");
                    scanf("%d", &op1);
                    scanf("%d", &op2);
                    rent_bike__createDiscount(op1,op2);
                    break;
            case 0:
                    printf("Encerrando programa ...\n");
                    exit(0);
                    break;
            default:
                    printf("Nenhuma das opçoes \n");
        }
    }
    
    return 0;
} 