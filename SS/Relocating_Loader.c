//Relocating Loader 

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main()
{
    char progname[20],add[10],length[10],bitmask[10],ch,reloc_bit,input[10];
    int addr,actualaddr,opcode,address,len,start;
    FILE *fp1,*fp2;

    printf("\nPlease enter the actual starting address: ");
    scanf("%d",&start);

    printf("\nContents of Input File:\n");
    fp1 = fopen("reloc_input.txt","r");
    ch = fgetc(fp1);
    while(ch != EOF)
    {
        printf("%c",ch);
        ch = fgetc(fp1);
    }
    fclose(fp1);

    printf("\n***** Program Loaded in Memory *****\n");
    fp2 = fopen("reloc_input.txt","r");
    fscanf(fp2,"%s",input);
    while(strcmp(input,"E") != 0)
    {
        if(strcmp(input,"H")==0)
        {
            fscanf(fp2,"%s",add);
            fscanf(fp2,"%s",length);
            fscanf(fp2,"%s",input);
        }
        
        if(strcmp(input,"T")==0)
        {
            fscanf(fp2,"%d",&address);
            address += start;
            fscanf(fp2,"%s",bitmask);
            len = strlen(bitmask);
            for(int i=0;i<len;i++)
            {
                fscanf(fp2,"%d",&opcode);
                addr = opcode % 10000;
                opcode = opcode/10000;
                reloc_bit = bitmask[i];
                if(reloc_bit == '0')
                    actualaddr = addr;
                else
                    actualaddr = addr + start;
                printf("%d\t%d%d\n",address,opcode,actualaddr);
                address += 3;
            }
        }
        fscanf(fp2,"%s",input);
    }
    fclose(fp2);

}