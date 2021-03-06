module TRAX_test;

reg clock = 0;
reg reset = 0;
reg [7:0] UART1_data;
reg [7:0] UART2_data;
always #5 clock = ~clock;
reg UART1_send,UART2_send;

TRAX inst1(TRAX1_rx,TRAX1_tx,clock);
TRAX inst2(TRAX2_rx,TRAX2_tx,clock);


UART inst3(,UART1_send,UART1_data,clock,reset,UART1_tx,UART1_done,,);
UART inst4(,UART2_send,UART2_data,clock,reset,UART2_tx,UART2_done,,);

assign TRAX1_rx = UART1_tx & TRAX2_tx;
assign TRAX2_rx = UART2_tx & TRAX1_tx;



integer i , j;

initial
begin
UART1_send = 1;
for(i = 0 ; i < 3; i = i + 1)
begin
	if(i == 0)
	UART1_data = "-";
	if(i==1)
	UART1_data = @(posedge UART1_done)"W";
	if(i == 2)
	UART1_data = @(posedge UART1_done)"\n";
end
	#1000 UART1_send = 0;
end
initial
begin
UART2_send = 1;
for(j = 0 ; j < 3; j = j + 1)
begin
	if(j == 0)
	UART2_data = "-";
	if(j==1)
	UART2_data = @(posedge UART2_done)"B";
	if(j == 2)
	UART2_data = @(posedge UART2_done)"\n";

end
	#1000 UART2_send = 0;
end
endmodule
