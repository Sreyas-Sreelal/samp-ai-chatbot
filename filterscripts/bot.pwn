#include<a_samp>
#include<zcmd>
#include<a_http>

#define BOT_NAME "Cosmic"
#define RED "{FF0000}"
#define WHITE "{FFFFFF}"

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
        format(buffer,sizeof(buffer),RED BOT_NAME WHITE": %s",data);
        SendClientMessage(playerid, -1, buffer);
    }
    else
    {
        SendClientMessage(playerid,-1,RED BOT_NAME  WHITE": Something happened to brain :( please ask again");
        printf("[DEBUG] Response code is %d",response_code);
    }
    return 1;
}
CMD:ask(playerid,params[])
{
    new name[MAX_PLAYER_NAME],msg[128];
    GetPlayerName(playerid, name,sizeof(name));
    format(msg, sizeof(msg),"%s: %s",name,params);
    SendClientMessageToAll(-1,msg);
    replacespace(params);
    printf("[DEBUG]params after replcaing space is %s",params);
    new inputtext[256]="localhost:5000/respond/";
    strcat(inputtext, params);
    HTTP(playerid, HTTP_GET, inputtext,"", "AskBot");
    return 1;
}

replacespace(str[])
{
	new i=-1;
	while(str[++i])
	{
		if(str[i]==' ')
			str[i]='+';
	}
}