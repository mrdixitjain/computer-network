#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define SERVER_PORT 5988
#define SERVER_IPADDR "172.21.4.224"
int main(){
    struct sockaddr_in cliaddr,servaddr;
    int sockfd,confd,clilen;
    sockfd = socket(AF_INET , SOCK_STREAM , 0) ;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(SERVER_PORT);
    servaddr.sin_addr.s_addr =inet_addr(SERVER_IPADDR) ; // or inet_pton()
    connect(sockfd, (struct sockaddr *) &servaddr, sizeof(servaddr)) ;
    clilen = sizeof(cliaddr);
    // /* getsockname(sockfd, (struct sockaddr *) &cliaddr, &clilen); */
    // /* printf("Client socket has IP: %s\n", inet_ntoa(cliaddr.sin_addr)); */
    // /* printf("Client socket has Port: %hu\n", ntohs(cliaddr.sin_port)); */
    for(; ;){
        char buf[]="hey3";
        //printf("Enter data:\n");
        //scanf("%s",buf) ;
        write(sockfd, buf, strlen(buf));
        read(sockfd, buf, strlen(buf));
        printf("Received Data :%s\n",buf);
        
    }
    close(sockfd);
    exit(0);
}
