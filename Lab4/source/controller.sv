module controller
  (
  input  wire clk,
  input  wire n_reset,
  input  wire dr,
  input  wire overflow,
  output reg cnt_up,
  output wire modwait,
  output reg [1:0] op,
  output reg [3:0] src1,
  output reg [3:0] src2,
  output reg [3:0] dest,
  output wire err
  );
  
  typedef enum bit [3:0] {IDLE, EIDLE, STORE, SORT1, SORT2, SORT3, SORT4, ADD1, ADD2, ADD3} state_type;
  state_type state, nextstate;
  
  reg tmpwait1;
  reg tmperr;
  assign modwait = tmpwait1;
  assign err = tmperr;
    
  always@(posedge clk, negedge n_reset) begin : Reset_Logic
    if(1'b0 == n_reset) begin
      state <= IDLE;
    end else begin
      state <= nextstate;
    end
  end
  

  always @ (state, dr, overflow) begin : State_Logic
    //state <= nextstate;
    nextstate = state; //try this to see if it works
    case(state)
      IDLE: begin
        if (dr == 1'b0) begin
          nextstate = IDLE;
        end else begin
          nextstate = STORE;
        end
      end
      
      EIDLE: begin
        if (dr == 1'b0) begin
          nextstate = EIDLE;
        end else begin
          nextstate = STORE;
        end
      end
      
      STORE: begin
        if (dr == 1'b0) begin
          nextstate = EIDLE;
        end else begin
          nextstate = SORT1;
        end
      end
      
      SORT1: begin
        nextstate = SORT2;
      end
        
      SORT2: begin
        nextstate = SORT3;
      end
        
      SORT3: begin
        nextstate = SORT4;
      end
        
      SORT4: begin
        nextstate = ADD1;
      end
    
      ADD1: begin
        if (overflow == 1'b1) begin
          nextstate = EIDLE;
        end else begin
          nextstate = ADD2;
        end
      end
      
      ADD2: begin
        if (overflow == 1'b1) begin
          nextstate = EIDLE;
        end else begin
          nextstate = ADD3;
        end
      end
        
      ADD3: begin
        if (overflow == 1'b1) begin
          nextstate = EIDLE;
        end else begin
          nextstate = IDLE;
        end
      end
      
      default: begin
        nextstate = IDLE;
      end
    endcase
  end
  
   always @ (state) begin : Register_Logic
    case(state)
      IDLE: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h0; src1 = 4'hf; src2 = 4'hf; dest = 4'hf;
        tmpwait1 = 1'b0;
      end
      
      EIDLE: begin
        cnt_up = 1'b0; tmperr = 1'b1;
        op = 2'h0; src1 = 4'hf; src2 = 4'hf; dest = 4'hf;
        tmpwait1 = 1'b0;
      end
      
      STORE: begin
        cnt_up = 1'b1; tmperr = 1'b0;
        op = 2'h2; src1 = 4'hf; src2 = 4'hf; dest = 4'h7;
        tmpwait1 = 1'b1;
      end
        
      SORT1: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h1; src1 = 4'h4; src2 = 4'hf; dest = 4'h3;
	      tmpwait1 = 1'b1;
      end
        
      SORT2: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h1; src1 = 4'h5; src2 = 4'hf; dest = 4'h4;
	     tmpwait1 = 1'b1;
      end
        
      SORT3: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h1; src1 = 4'h6; src2 = 4'hf; dest = 4'h5;
	       tmpwait1 = 1'b1;
      end
        
      SORT4: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h1; src1 = 4'h7; src2 = 4'hf; dest = 4'h6;
	     tmpwait1 = 1'b1;
      end
        
      ADD1: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h3; src1 = 4'h3; src2 = 4'h4; dest = 4'h2;
	     tmpwait1 = 1'b1;
      end
        
      ADD2: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h3; src1 = 4'h2; src2 = 4'h5; dest = 4'h1;
	       tmpwait1 = 1'b1;
      end
              
      ADD3: begin
        cnt_up = 1'b0; tmperr = 1'b0;
        op = 2'h3; src1 = 4'h1; src2 = 4'h6; dest = 4'h0;
	      tmpwait1 = 1'b1;
      end

     default: begin
        cnt_up = 1'b0; tmperr = 1'b1;
        op = 2'h0; src1 = 4'hf; src2 = 4'hf; dest = 4'hf;
        tmpwait1 = 1'b1;
     end

    endcase
  end
  
endmodule
