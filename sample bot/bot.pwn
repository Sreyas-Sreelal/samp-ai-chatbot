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
        format(buffer,sizeof(buffer),RED BOT_NAME WHITE"(bot): %s",data);
        SendClientMessage(playerid, -1, buffer);
    }
    else if(response_code == HTTP_ERROR_CANT_CONNECT)
    {
        print("[WARNING] Can't connect to flask server");
        SendClientMessage(playerid,-1,RED BOT_NAME" is offline!");
    }
    else
    {
        SendClientMessage(playerid,-1,RED BOT_NAME  WHITE"(bot): Something happened to my brain :( can you repeat what you just said?");
        printf("[DEBUG] Response code is %d",response_code);
    }
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new payload[30];
    format(payload,sizeof(payload),"localhost:5000/delete/%d",playerid);
    HTTP(playerid, HTTP_GET, payload,"", "");
    return 1;
}
CMD:ask(playerid,params[])
{
    new name[MAX_PLAYER_NAME],msg[128];
    GetPlayerName(playerid, name,sizeof(name));
    format(msg, sizeof(msg),"%s: %s",name,params);
    SendClientMessageToAll(-1,msg);
    replacespace(params);
    printf("[DEBUG]params after replacing space is %s",params);
    new inputtext[170];
    format(inputtext,sizeof(inputtext),"localhost:5000/respond/%d/",playerid);
    strcat(inputtext, params);
    HTTP(playerid, HTTP_GET, inputtext,"", "AskBot");
    return 1;
}

replacespace(str[])
{
	new i=-1;
	while(str[++i])
		if(str[i]==' ')
			str[i]='+';
}

