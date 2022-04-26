#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main()
{
    char rec[20];
    char progname[20];
    char ch;
    
    int length,start,locctr;

    FILE *fp1,*objptr;

    printf("\nThe Contents of Input File:\n");
    fp1 = fopen("program.txt","r");
    ch = fgetc(fp1);

    while(ch!= EOF)
    {
        printf("%c",ch);
        ch = fgetc(fp1);
    }

    fclose(fp1);

    printf("\n\n*****Program Loaded In Memory*****\n");
    printf("\nADDRESS\tOBJECT CODE\n");
    objptr = fopen("program.txt","r");
    fscanf(objptr,"%s",rec);
    if(strcmp(rec,"H")==0)
    {
        fscanf(objptr,"%s",progname);
        fscanf(objptr,"%X",&start);
        locctr = start;
        fscanf(objptr,"%X",&length);
        fscanf(objptr,"%s",rec);
    }
    else
    {
        fclose(objptr);
        exit(0);
    }

    while(strcmp(rec,"E")!=0)
    {
        if(strcmp(rec,"T")==0)
        {
            fscanf(objptr,"%X",&start);
            locctr = start;
            fscanf(objptr,"%X",&length);
        } 
        else
        {
            if(locctr > 0xFFFF)
                printf("0");
            else if(locctr > 0xFFF)
                printf("00");
            else if(locctr > 0xFF)
                printf("000");
            else if(locctr > 0xF)
                printf("0000");
            else
                printf("00000");
            
            printf("%X\t%s\n",locctr,rec);
            locctr+=3;
        }  
        fscanf(objptr,"%s",rec);      
    }
    
    fclose(objptr);        

}