module blinkdir (
    input CLK,
    input RST,
    input BTN,
    output reg [3:0] LED
);

/////////// BUTTON
wire UP;
debounce d0 (.CLK(CLK), .RST(RST), .BTNIN(BTN), .BTNOUT(UP));

reg [1:0] mode;

always @(posedge CLK) begin
    if (RST)
        mode <= 2'h0;
    else if (UP)
        mode <= mode + 2'h1;

    if (mode == 2'd3)
        mode <= 2'h0;
end
/////////// BUTTON

//////////// CLOCK
reg [22:0] cnt23;

always @( posedge CLK ) begin
	if ( RST )
		cnt23 <= 23'h0;
	else
		cnt23 <= cnt23 + 1'h1;
end

wire ledcnten = (cnt23 == 23'h7fffff);

reg [1:0] cnt2;
reg [2:0] cnt3;

always @( posedge CLK ) begin
	if (RST)
		cnt2 <= 2'h0;
	else if (ledcnten)
		if (cnt2 == 2'd3)
			cnt2 <= 2'h0;
		else
			cnt2 <= cnt2 + 1'h1;
end

always @( posedge CLK ) begin
	if (RST)
		cnt3 <= 3'h0;
	else if (ledcnten)
		if (cnt3 == 3'd5)
			cnt3 <= 3'h0;
		else
			cnt3 <= cnt3 + 1'h1;
end
//////////// CLOCK

//////////// LED
always @* begin
    /// left <-> right
    if ( mode==2'd0)
        case ( cnt3 )
            3'd0: LED = 4'b0001;
            3'd1: LED = 4'b0010;
            3'd2: LED = 4'b0100;
            3'd3: LED = 4'b1000;
            3'd4: LED = 4'b0100;
            3'd5: LED = 4'b0010;
            default:LED = 4'b0000;
        endcase
    else if (mode==2'd1)
        /// right -> left
        case ( cnt2 )
            2'd0: LED = 4'b0001;
            2'd1: LED = 4'b0010;
            2'd2: LED = 4'b0100;
            2'd3: LED = 4'b1000;
            default:LED = 4'b0000;
        endcase
    else if (mode==2'd2)
        /// left -> right
        case ( cnt2 )
            2'd0: LED = 4'b1000;
            2'd1: LED = 4'b0100;
            2'd2: LED = 4'b0010;
            2'd3: LED = 4'b0001;
            default:LED = 4'b0000;
        endcase
end

endmodule