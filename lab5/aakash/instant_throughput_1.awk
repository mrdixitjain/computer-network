BEGIN{
       recv=0
       currentym= prevtym = 0
       timetic=0.0001
}

{
event=$1
time=$2
packet_type=$5
packet_size=$6



if(prevtym == 0)
        prevtym=time
if( $5=="cbr" && $1=="r") {
        recv=recv + $6
        currentym=currentym+(time-prevtym)
        if( currentym >= timetic) {
         printf("%f %f \n",time,(recv/currentym)*(8/1000000))
         recv=0
         currentym=0
        }
        prevtym=time
 }
}        
END {
printf("\n")
}
