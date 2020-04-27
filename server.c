#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include<stdio.h>
#include<stdlib.h>
#define SERVER_PORT 9988
int main(){
    int sockfd, clilen;
    struct sockaddr_in servaddr, cliaddr;
    sockfd = socket( AF_INET, SOCK_DGRAM, 0);
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(SERVER_PORT);
    servaddr.sin_addr.s_addr =htonl(INADDR_ANY);
    if (bind(sockfd,(struct sockaddr*)&servaddr,sizeof(servaddr)) <0 ){
        printf("Server Bind Error");
        exit(1);
    }
    for(; ; ){ 
        char buf[256];
        clilen= sizeof(cliaddr);
        recvfrom(sockfd,buf,256,0,(struct sockaddr*)&cliaddr,&clilen);
        printf("Server Received:%s\n",buf);
        sendto(sockfd,"Server Got Message",18, 0,(struct sockaddr*)&cliaddr,clilen);
    }
}
