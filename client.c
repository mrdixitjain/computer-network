#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define SERVER_PORT 9988
#define SERVER_IPADDR "172.21.4.224"
int main()
{
    int sockfd,len, len1;
    //char buf[256];
    struct sockaddr_in cliaddr,servaddr;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(SERVER_PORT);
    servaddr.sin_addr.s_addr = inet_addr(SERVER_IPADDR);
    sockfd = socket( AF_INET, SOCK_DGRAM, 0);
    for(; ; ){
    printf("Enter Message\n");
    len= sizeof(servaddr);
  //fgets(buf,255,stdin);
    char buf[]="hello br1";
    sendto(sockfd,buf,strlen(buf), 0,(struct sockaddr*)&servaddr,len);
    recvfrom(sockfd,buf,256,0,(struct sockaddr*)&servaddr, &len);
        //printf("Enter Message\n");
    printf("Client Received: %s \n",buf);
    }
    close(sockfd);
    //printf("hello");
}
