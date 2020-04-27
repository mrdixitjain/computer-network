BEGIN{ 
	packet_dropped=0;
	packet_sent=0;
	packet_recieved=0;
	pkt=0;
	time=0;
	
}
{
	if($1=="d"){
		packet_dropped++;
	}
	if($1=="r"){
		packet_recieved++;
	}
	if($1=="s"){
		packet_sent++;
	}
	if($1=="r"){
	    pkt=pkt+$6;
	    time=time+$2;
	}
}
END{ 
	printf("No of packets dropped=%d\n",packet_dropped);
	printf("No of packets recieved=%d\n",packet_recieved);
	packet_sent=packet_dropped+packet_recieved;
	printf("No of packets sent=%d\n",packet_sent);
	printf("Packet delivery ratio=%.4f\n",packet_recieved/packet_dropped);
	printf("Throughput=%.4fMbps\n",((pkt/time)*(8/1000000)));
}
