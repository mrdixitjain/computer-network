BEGIN{ 
	packet_dropped_tcp=0;
	packet_dropped_udp=0;
	packet_sent_tcp=0;
	packet_sent=0;
	packet_recieved=0;
	packet_sent_udp=0;
	packet_recieved_tcp=0;
	packet_recieved_udp=0;
	pkt=0;
	time=2.9;
	
}
{
	if($1=="d"){
		packet_dropped++;
	}
	if($1=="r"){
		packet_recieved++;
	}
	if($1=="r"){
	    pkt=pkt+$6;
	}
}
END{
	packet_sent=packet_dropped+packet_recieved;
	printf("No of packets sent=%d\n",packet_sent);
	printf("No of packets dropped=%d\n",packet_dropped);
	printf("No of packets received=%d\n",packet_recieved);
	printf("Packet delivery ratio=%.4f\n",packet_recieved/packet_sent);
	printf("Throughput=%.4fMbps\n",((pkt/time)*(8/1000000)));
}
