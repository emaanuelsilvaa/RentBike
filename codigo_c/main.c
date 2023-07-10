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

    rent_bike__INITIALISATION();

    while(true){
        printf("=================BEM VINDO AO RENTBIKE ================\n"); 

        printf("=================MENU BIKE ================\n"); 
        printf("PARA INSERIR UMA BIKE DIGITE 1\n"); 
        printf("PARA EXCLUIR UMA BIKE DIGITE 2\n");  
        printf("PARA RESETAR A SAUDE DE ALGUMA BIKE DIGITE 3\n"); 
        printf("PARA SABER A SAUDE DE ALGUMA BIKE DIGITE 4\n"); 
        printf("PARA PARA INSERIR DANOS A ALGUMA BIKE DIGITE 5\n"); 
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
            case 0:
                    printf("Encerrando programa ...\n");
                    exit(0);
                    break;
            default:
                    printf("Nenhuma das opçoes \n");
        }
    }

    printf("Valor de j e' %d\n", op);
    
    return 0;
} 