#include<a_samp>
#include<zcmd>
#include<a_http>

#define BOT_NAME "Cosmic"

public OnFilterScriptInit()
{
    print("Starting....\n");
    return 1;
}

forward AskBot(playerid,response_code,data[]);
public AskBot(playerid,response_code,data[])
{
    
    if(response_code == 200)
    {
        new buffer[300];
        format(buffer,sizeof(buffer),BOT_NAME":%s",data);
        SendClientMessage(playerid, -1, buffer);
    }
    else
    {
        SendClientMessage(playerid,-1,BOT_NAME":Something happened to brain :( please ask again");
        printf("[DEBUG] Response code is %d",response_code);
    }
    return 1;
}
CMD:ask(playerid,params[])
{
    new inputtext[256]="localhost:5000/";
    strcat(inputtext, params);
    HTTP(playerid, HTTP_GET, inputtext,"", "AskBot");
    return 1;
}
