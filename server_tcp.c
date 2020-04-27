#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include<stdio.h>
#include<stdlib.h>
#include <unistd.h>
#include<string.h>
#define SERVER_PORT 5988
//Iterative Server
int main() {
    struct sockaddr_in cliaddr,servaddr;
    int sockfd,confd,clilen;
    sockfd = socket(AF_INET , SOCK_STREAM , 0) ;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(SERVER_PORT);
    servaddr.sin_addr.s_addr =htonl( INADDR_ANY) ;
    bind(sockfd, (struct sockaddr *)&servaddr,sizeof(servaddr));
    listen(sockfd,2);
    while(1) {
        char buf[256];
        clilen=sizeof(cliaddr);
        confd= accept(sockfd,(struct sockaddr *)&cliaddr,&clilen);
        if(fork()==0){
            close(sockfd);
            printf("Client IP: %s\n", inet_ntoa(cliaddr.sin_addr));
            printf("Client Port: %hu\n", ntohs(cliaddr.sin_port)); 
            //while(1){
                read(confd, buf, 256);
                printf("Received:%s %d\n",buf, getpid());
                write(confd, buf, strlen(buf));
            //}
        }
        break;
        close(confd);
    }
    return 0;
}
