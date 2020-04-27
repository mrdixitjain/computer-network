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
	time=4.4;
	
}
{
	if($1=="d" && $5=="tcp"){
		packet_dropped_tcp++;
	}
	if($1=="d" && $5=="cbr"){
		packet_dropped_udp++;
	}
	if($1=="r" && $5=="tcp"){
		packet_recieved_tcp++;
	}
	if($1=="r" && $5=="cbr"){
		packet_recieved_udp++;
	}
	if($1=="r"){
	    pkt=pkt+$6;
	}
}
END{ 
	printf("No of packets dropped by tcp=%d\n",packet_dropped_tcp);
	printf("No of packets dropped by udp=%d\n",packet_dropped_udp);
	printf("No of packets recieved by tcp=%d\n",packet_recieved_tcp);
	printf("No of packets recieved by udp=%d\n",packet_recieved_udp);
	packet_sent_tcp=packet_dropped_tcp+packet_recieved_tcp;
	packet_sent_udp=packet_dropped_udp+packet_recieved_udp;
	printf("No of packets sent by tcp=%d\n",packet_sent_tcp);
	printf("No of packets sent by udp=%d\n",packet_sent_udp);
	packet_sent=packet_sent_tcp+packet_sent_udp;
	packet_recieved=packet_recieved_tcp+packet_recieved_udp;
	printf("Packet delivery ratio=%.4f\n",packet_recieved/packet_sent);
	printf("Throughput=%.4fMbps\n",((pkt/time)*(8/1000000)));
}
