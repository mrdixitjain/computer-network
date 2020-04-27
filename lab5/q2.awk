BEGIN{
    tcpDropped = 0;
    tcpReceived = 0;
    udpDropped = 0;
    udpReceived = 0;
    dropped=0;
    received=0;
    count=0;
    totalDelay=0;
}
{
    event = $1;
    type=$5;
    generationTime=$2;
    rdTime=$3;
    totalDelay=totalDelay+rdTime-generationTime;
    if(event == "d"){
        dropped++;
        if(type=="tcp")
            tcpDropped++;
        else
            udpDropped++;
    }
    if(event == "r"){
        received++;
        if(type=="tcp")
            tcpReceived++;
        else
            udpReceived++;
    }   
}
END{
    
    printf("The no.of packets dropped of TCP : %d\n",tcpDropped);
    printf("The no.of packets recieved of TCP : %d\n",tcpReceived);
    printf("The no.of packets dropped of UDP : %d\n",udpDropped);
    printf("The no.of packets recieved of UDP: %d\n",udpReceived);
    printf("Total no.of packets dropped : %d\n",dropped);
    printf("Total no.of packets recieved : %d\n",received);
    printf("Total Delay : %d\n", totalDelay);
}
